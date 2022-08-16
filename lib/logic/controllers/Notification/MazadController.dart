import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';

class MazadController extends GetxController{

  var select_smile = 3.obs ;
  var product_id , isRate = false ;
  String notes = "";
  final storage=const FlutterSecureStorage();


  void set_select_smile(var val)
  {
    select_smile.value = val;
  }



  @override
  void onInit() {
    super.onInit();
  }
}