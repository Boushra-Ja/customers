import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../models/Boshra/Store/ShopModel.dart';
import '../../models/Boshra/products/ProductModel.dart';
import '../../models/batool/FavoriteStore.dart';

class FavoriteController extends GetxController {
  var Tabbar = 1.obs;
  var loading = true.obs;
  var check = ''.obs;
  var listfavoite = <Product>[].obs;
  var listfavoitestore = <FavoriteStore>[].obs;
  late List jsonResponse;
  String? selectedValue;
  var isLoading = true.obs;
  final storage = const FlutterSecureStorage();
  var token;

  void changeTabbar(int index) {
    Tabbar.value = index;
    update();
  }

  FetchData_favorite() async {
    final response = await http.get(
      Uri.parse('${MyApp.api}/api/FavoriteProduct/index'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      ProductModel productModel =
          ProductModel.fromJson(jsonDecode(response.body));
      listfavoite.assignAll(productModel.data);

      if (listfavoite.isEmpty) {
        check.value = 'NODATA';
        update();
      }

      if (listfavoite.isNotEmpty) {
        check.value = 'DATA';

        update();

        for (int i = 0; i < listfavoite.length; i++) {
          for (int k = 0; k < listfavoite[i].all_review.length; k++)
            listfavoite[i].review +=
                listfavoite[i].all_review.elementAt(k)['value'] as int;
        }
      }
    }
  }

  FetchData_favorite_store() async {
    final response = await http.get(
      Uri.parse('${MyApp.api}/api/FavoriteStore/Show_Favorite'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      FavoriteStoreModel shopModel = FavoriteStoreModel.fromJson(jsonDecode(response.body));
      listfavoitestore.assignAll(shopModel.data);


      // for (int i = 0; i < listfavoitestore.length; i++) {
      //   for (int k = 0; k < listfavoitestore[i].all_review.length; k++)
      //     listfavoitestore[i].review +=
      //         listfavoitestore[i].all_review.elementAt(k)['value'] as int;
      //   int j = (listfavoitestore[i].review / 3).toInt();
      //   listfavoitestore[i].review = j;
      // }
    }
  }

  @override
  void onInit() async {
    token = await storage.read(key: 'token');
    FetchData_favorite();
    FetchData_favorite_store();
    super.onInit();
  }

  void dispose() {
    super.dispose();
  }
}
