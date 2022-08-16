import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

class RatingProductController extends GetxController{

  var select_smile = 3.obs ;
  var product_id , isRate = false ;
  String notes = "";
  var user_name  , email  , image , user_id  , token;
  final storage=const FlutterSecureStorage();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  RatingProductController(this.product_id) ;

  void set_select_smile(var val)
  {
    select_smile.value = val;
  }

  Future<void> rating_product()async{
    user_id  = await storage.read(key: 'id') ;
    token  = await storage.read(key: 'token') ;

    final response = await http.post(
        Uri.parse('${MyApp.api}/api/rating_product'),
        headers: {'Content-Type': 'application/json',
    'Accept': 'application/json', 'Authorization': 'Bearer $token'},
        body: jsonEncode(<String, dynamic>{
          "customer_id": int.parse(user_id),
          "product_id": product_id,
          "notes" : notes ,
          "value" : select_smile.value
        }));

    if(response.statusCode == 200)
    {
      print("successs");
      isRate = true ;
      update() ;
    }

  }


  @override
  void onInit() {
    super.onInit();
  }
}