import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';
import '../../../models/batool/ClassificationsModel.dart';
import '../../../models/batool/FavoriteProduct2Model.dart';
import '../../../models/batool/ProductModel.dart';
import '../Notification/SingltoneNotification.dart';


class ProductController extends GetxController {
  var flist = <int>[].obs;
  final controller2 = Get.put(SingltoneNotification());

  var i=0.obs;

  var loading = true.obs;
  var listpoduct_discount = <products>[].obs;
  var listpoduct_salary = <products>[].obs;
  var listpoduct_sales = <products>[].obs;
  var listpoduct_favorite = <products>[].obs;
  var listpoduct_f = <Favorite_product2>[].obs;
  var listpoduct_classification = <Classifications>[].obs;
  ////saerch from boshra
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  var search_name = " " ;

  var isLoading = true.obs;
  late List<dynamic> jsonResponse;
  var  selectedValue=[] ;
  String? selectedValue10;
  var Col = 1.obs;
  var token=''.obs;
  var col = 0.obs;

  DropDown(var id, var title) async {
    final response = await http.get(
      Uri.parse('${MyApp.api}/api/Product/ShowClassification/$id/$title'),
    );

    if (response.statusCode == 200) {
      productsModel shopModel = productsModel.fromJson(jsonDecode(response.body));

      if (id == 1)
        listpoduct_sales.assignAll(shopModel.data);
      else if (id == 2)
        listpoduct_salary.assignAll(shopModel.data);
      if (id == 4)
        listpoduct_favorite.assignAll(shopModel.data);

    }
    else
      return "000000000000000000000000000000000000000";
  }


  bool check(int productId) {
    for (int i = 0; i < listpoduct_f.length; i++) {
      if (productId == listpoduct_f.elementAt(i).product_id) return true;
    }
    return false;
  }

  void changeCol(var data, int col, int productId) {
    if (data == "add") {
      print("to red");
    } else {
      print("to black");
    }

    Col.value = col;

    update();
  }

  classification_get() async {


    final response = await http.get(Uri.parse('${MyApp.api}/api/Show_p'));

    if (response.statusCode == 200) {
      ClassificationModel classificationModel = ClassificationModel.fromJson(jsonDecode(response.body));
      listpoduct_classification.assignAll(classificationModel.data);


      for(int i=0;i<listpoduct_classification.length;i++)
      {
        Secondary s=new Secondary(title: listpoduct_classification.elementAt(i).title);
        listpoduct_classification.elementAt(i).mySecondary.add( s);
      }
      selectedValue.insert(0,"");

      for(int i=0;i<listpoduct_classification.length;i++) {
        // print(listpoduct_classification.elementAt(i).title);
        selectedValue.insert(i + 1, listpoduct_classification.elementAt(i).title);
      }

    } else
      return null;
  }

  get() async {
    // var col =0.obs;
    var c = await storage.read(key: "isDarkMode");
    if (c == "false") {
      col.value = 0;
      // print("********************false****************************");
    } else {
      col.value = 1;
      // print("********************true****************************");
    }
  }

  FetcDhataList_f({required token}) async {
    final response = await http.get(Uri.parse('${MyApp.api}/api/FavoriteProduct/show'),
      headers: {'Content-Type': 'application/json',
        'Accept': 'application/json', 'Authorization': 'Bearer $token'},) ;

    if (response.statusCode == 200) {
      print(response.body);

      jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => new Favorite_product2.fromJson(data))
          .toList();
    } else
      return null;
  }


  Future<void> discount_get() async {
    final response = await http.get(
      Uri.parse('${MyApp.api}/api/Product/Order_discount'),
    );
    if (response.statusCode == 200) {
      productsModel shopModel =
      productsModel.fromJson(jsonDecode(response.body));
      listpoduct_discount.assignAll(shopModel.data);
      for (int i = 0; i < listpoduct_discount.length; i++) {
        if (listpoduct_discount[i].rating.length != 0)
          for (int j = 0; j < listpoduct_discount[i].rating.length; j++) {
            if (listpoduct_discount[i].rating[j]['value'] as int == 0)
              listpoduct_discount[i].count_0++;
            else if (listpoduct_discount[i].rating[j]['value'] as int == 1)
              listpoduct_discount[i].count_1++;
            else if (listpoduct_discount[i].rating[j]['value'] as int == 2)
              listpoduct_discount[i].count_2++;
          }
        else {
          listpoduct_discount[i].count_0 = -1;
          listpoduct_discount[i].count_1 = -1;
          listpoduct_discount[i].count_2 = -1;
        }

        if (listpoduct_discount[i].count_0 > listpoduct_discount[i].count_1) {
          if (listpoduct_discount[i].count_0 > listpoduct_discount[i].count_2)
            listpoduct_discount[i].rating = 0;
          else
            listpoduct_discount[i].rating = 2;
        } else if (listpoduct_discount[i].count_0 <
            listpoduct_discount[i].count_1) {
          if (listpoduct_discount[i].count_1 > listpoduct_discount[i].count_2)
            listpoduct_discount[i].rating = 1;
          else
            listpoduct_discount[i].rating = 2;
        }

        if (listpoduct_discount[i].count_0 ==
            listpoduct_discount[i].count_1) if (listpoduct_discount[i]
            .count_1 ==
            listpoduct_discount[i]
                .count_2) if (listpoduct_discount[i].count_1 != -1)
          listpoduct_discount[i].rating = 1;
      }

    } else {
      print("errorrrrrdiscount");
    }
  }

  Future<void> favorite_get() async {
    token.value = (await storage.read(key: "token"))!;

    final response = await http.get(
      Uri.parse('${MyApp.api}/api/Product/Order_favorite'),
      headers: {'Content-Type': 'application/json',
        'Accept': 'application/json', 'Authorization': 'Bearer $token'},) ;

    print(response.statusCode);
    if (response.statusCode == 200) {
      productsModel shopModel = productsModel.fromJson(jsonDecode(response.body));
      listpoduct_favorite.assignAll(shopModel.data);
      for (int i = 0; i < listpoduct_favorite.length; i++) {
        if (listpoduct_favorite[i].rating.length != 0)
          for (int j = 0; j < listpoduct_favorite[i].rating.length; j++) {
            if (listpoduct_favorite[i].rating[j]['value'] as int == 0)
              listpoduct_favorite[i].count_0++;
            else if (listpoduct_favorite[i].rating[j]['value'] as int == 1)
              listpoduct_favorite[i].count_1++;
            else if (listpoduct_favorite[i].rating[j]['value'] as int == 2)
              listpoduct_favorite[i].count_2++;
          }
        else {
          listpoduct_favorite[i].count_0 = -1;
          listpoduct_favorite[i].count_1 = -1;
          listpoduct_favorite[i].count_2 = -1;
        }

        if (listpoduct_favorite[i].count_0 > listpoduct_favorite[i].count_1) {
          if (listpoduct_favorite[i].count_0 > listpoduct_favorite[i].count_2)
            listpoduct_favorite[i].rating = 0;
          else
            listpoduct_favorite[i].rating = 2;
        } else if (listpoduct_favorite[i].count_0 <
            listpoduct_favorite[i].count_1) {
          if (listpoduct_favorite[i].count_1 > listpoduct_favorite[i].count_2)
            listpoduct_favorite[i].rating = 1;
          else
            listpoduct_favorite[i].rating = 2;
        }

        if (listpoduct_favorite[i].count_0 ==
            listpoduct_favorite[i].count_1) if (listpoduct_favorite[i]
            .count_1 ==
            listpoduct_favorite[i]
                .count_2) if (listpoduct_favorite[i].count_1 != -1)
          listpoduct_favorite[i].rating = 1;
      }

    }
    else {
      print("errorrrrrfavorite");
    }
  }

  Future<void> salary_get() async {
    final response = await http.get(
      Uri.parse('${MyApp.api}/api/Product/Order_Salary'),
    );
    if (response.statusCode == 200) {
      productsModel shopModel = productsModel.fromJson(jsonDecode(response.body));
      listpoduct_salary.assignAll(shopModel.data);
      for (int i = 0; i < listpoduct_salary.length; i++) {
        if (listpoduct_salary[i].rating.length != 0)
          for (int j = 0; j < listpoduct_salary[i].rating.length; j++) {
            if (listpoduct_salary[i].rating[j]['value'] as int == 0)
              listpoduct_salary[i].count_0++;
            else if (listpoduct_salary[i].rating[j]['value'] as int == 1)
              listpoduct_salary[i].count_1++;
            else if (listpoduct_salary[i].rating[j]['value'] as int == 2)
              listpoduct_salary[i].count_2++;
          }
        else {
          listpoduct_salary[i].count_0 = -1;
          listpoduct_salary[i].count_1 = -1;
          listpoduct_salary[i].count_2 = -1;
        }

        if (listpoduct_salary[i].count_0 > listpoduct_salary[i].count_1) {
          if (listpoduct_salary[i].count_0 > listpoduct_salary[i].count_2)
            listpoduct_salary[i].rating = 0;
          else
            listpoduct_salary[i].rating = 2;
        } else if (listpoduct_salary[i].count_0 <
            listpoduct_salary[i].count_1) {
          if (listpoduct_salary[i].count_1 > listpoduct_salary[i].count_2)
            listpoduct_salary[i].rating = 1;
          else
            listpoduct_salary[i].rating = 2;
        }

        if (listpoduct_salary[i].count_0 ==
            listpoduct_salary[i].count_1) if (listpoduct_salary[i]
            .count_1 ==
            listpoduct_salary[i]
                .count_2) if (listpoduct_salary[i].count_1 != -1)
          listpoduct_salary[i].rating = 1;
      }

    } else {
      print("errorrrrrsalary");
    }
  }

  Future<void> sales_get() async {////////////////////
    final response = await http.get(
      Uri.parse('${MyApp.api}/api/Product/Order_sales'),
    );
    if (response.statusCode == 200) {
      productsModel shopModel =
      productsModel.fromJson(jsonDecode(response.body));
      listpoduct_sales.assignAll(shopModel.data);

      //

      for (int i = 0; i < listpoduct_sales.length; i++) {
        if (listpoduct_sales[i].rating.length != 0)
          for (int j = 0; j < listpoduct_sales[i].rating.length; j++) {
            if (listpoduct_sales[i].rating[j]['value'] as int == 0)
              listpoduct_sales[i].count_0++;
            else if (listpoduct_sales[i].rating[j]['value'] as int == 1)
              listpoduct_sales[i].count_1++;
            else if (listpoduct_sales[i].rating[j]['value'] as int == 2)
              listpoduct_sales[i].count_2++;
          }
        else {
          listpoduct_sales[i].count_0 = -1;
          listpoduct_sales[i].count_1 = -1;
          listpoduct_sales[i].count_2 = -1;
        }

        if (listpoduct_sales[i].count_0 > listpoduct_sales[i].count_1) {
          if (listpoduct_sales[i].count_0 > listpoduct_sales[i].count_2)
            listpoduct_sales[i].rating = 0;
          else
            listpoduct_sales[i].rating = 2;
        } else if (listpoduct_sales[i].count_0 < listpoduct_sales[i].count_1) {
          if (listpoduct_sales[i].count_1 > listpoduct_sales[i].count_2)
            listpoduct_sales[i].rating = 1;
          else
            listpoduct_sales[i].rating = 2;
        }

        if (listpoduct_sales[i].count_0 ==
            listpoduct_sales[i].count_1) if (listpoduct_sales[i]
            .count_1 ==
            listpoduct_sales[i].count_2) if (listpoduct_sales[i].count_1 != -1)
          listpoduct_sales[i].rating = 1;
      }

      isLoading.value = false;
      update();

    } else {
      print("errorrrrrsales");
    }
  }

  d()async{
    token.value=   (await storage.read(key: 'token'))! ;

  }
  @override
  void onInit() {
    d();
    ///controller2.inti();
    get();

    getData2();
    classification_get();
    discount_get();
    favorite_get();
    salary_get();
    sales_get();

  }

  getData2() async {
    try {
      loading.value = true;
      var result2 = await FetcDhataList_f(
        token : await storage.read(key: "token"),
      );


      if (result2 != null)
      {
        listpoduct_f.assignAll(result2);


      } else
        print("null");
    } finally {
      loading.value = false;
    }
    update();
  }


  ///boshra
  Future<void>search_products(var i)async{
    final response = await http.get(Uri.parse('${MyApp.api}/api/search/product/${search_name}/$i')) ;

    if(response.statusCode == 200) {

      productsModel productModel = productsModel.fromJson(jsonDecode(response.body));

      if (i == 1)
        listpoduct_sales.assignAll(productModel.data);
      else if (i == 2)
        listpoduct_salary.assignAll(productModel.data);
      if (i == 4)
        listpoduct_favorite.assignAll(productModel.data);



    }
  }


  void onSelected(String value, id) async {
    print(id);
    selectedValue[id]=value;
    update();
  }
}


