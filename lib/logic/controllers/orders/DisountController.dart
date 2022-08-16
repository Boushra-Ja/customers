import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';
import '../../../models/Boshra/orders/DiscountModel.dart';

class DiscountController  extends GetxController{

  var isApplied = false.obs ;
  var isLoading = false.obs ;
  var user_id  , code , token;
  final storage=const FlutterSecureStorage();
  List<DiscountCode> discount_list = <DiscountCode>[].obs ;

  void set_applied(val , ind){
    discount_list.elementAt(ind).isApplied = val ;
    update() ;
  }

  void set_code(val ){
    code = val ;
    update() ;
  }

  Future<void>fetch_discounts()async{
    user_id  = await storage.read(key: 'id') ;
    token  = await storage.read(key: 'token') ;

    final response = await http.get(Uri.parse(
        '${MyApp.api}/api/discounts_codes/${user_id}') ,  headers: {'Content-Type': 'application/json',
      'Accept': 'application/json', 'Authorization': 'Bearer $token'},);

    if(response.statusCode == 200)
      {
        DiscountCodeModel discountCodeModel = DiscountCodeModel.fromJson(jsonDecode(response.body));
        discount_list.assignAll(discountCodeModel.data) ;
      }
    isLoading.value = true ;


  }


  @override
  void onInit()async {
    super.onInit();
    await fetch_discounts() ;
  }

}