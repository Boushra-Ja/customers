import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../main.dart';
import '../../../models/Boshra/Store/NameModel.dart';

class ReportPageController extends GetxController {
  var isLoading = true.obs, isReport = true.obs;

  var selectedshopname = ''.obs, user_id;
  var selectedshopid;

  var content_report = '', token;
  final storage = const FlutterSecureStorage();
  late TextEditingController content_controller;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate2 = new GlobalKey<FormState>();
  List<ShopName> shopsList = <ShopName>[].obs;

  @override
  void onInit() async {
    user_id = await storage.read(key: 'id');
    token = await storage.read(key: 'token');
    content_controller = TextEditingController();
    await fetch_shops();
    super.onInit();
  }

  @override
  void dispose() {
    content_controller.dispose();
    super.dispose();
  }

  void set_content(var val) {
    content_report = val;
    update();
  }

  void set_selectedshopname(String val, int id) {
    selectedshopname.value = val;
    selectedshopid = id;
  }

  String? validate_shopname(var val) {
    if (selectedshopname.value == '') return "الرجاء اختيار اسم المتجر أولا";

    return null;
  }

  String? validate_content(var val) {
    if (val == '')
      return "الحقل مطلوب";
    else if (val.length < 30) return "محتوى الشكوى يجب أن يكون أكبر من 30 محرف";

    return null;
  }

  Future<void> fetch_shops() async {
    final response = await http.get(
      Uri.parse('${MyApp.api}/api/shop_names'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      ShopNameModel shopNameModel =
          ShopNameModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < shopNameModel.data.length; i++)
        shopsList.add(shopNameModel.data.elementAt(i));
    } else
      print("error");
    isLoading.value = false;
  }

  Future<void> report() async {
    isReport.value = false;


    var formdata = formstate.currentState;
    var formdata2 = formstate2.currentState;

    if (formdata2!.validate() && formdata!.validate()) {
      formdata.save();
      formdata2.save();
      final response = await http.post(
          ////user id
          Uri.parse('${MyApp.api}/api/report'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, dynamic>{
            "customer_id": user_id,
            "store_id": selectedshopid,
            "content": content_report
          }));

      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar("", "تمت عملية الابلاغ بنجاح ");
      } else
        print('error');
    }

    isReport.value = true;
    update();
  }
}
