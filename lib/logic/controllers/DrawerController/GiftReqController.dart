import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';
import '../../../models/Boshra/Store/NameModel.dart';
import '../../../models/Boshra/products/ProductModel.dart';
import '../../../view/Seggestions.dart';

class GiftReqController extends GetxController {
  var selectedAge = " "  ;
  var selectedMaterial =  "";
  var Gift_party = " " ;
  int fromprice = 0 , toprice = 1000;
  var isLoading = true.obs , isLoad = false.obs ;
  List<Product>products = <Product>[].obs ;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate2 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate3 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate4 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate5 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate6 = new GlobalKey<FormState>();

  var AgeFromlist = [
    "اطفال" , "شباب" , "كبار" ,"كل الاعمار"
  ];


  Map<String , ShopName>Materiallist = <String , ShopName>{}.obs ;

  void setSelectedAge(var value) {
    selectedAge = value;
    update() ;
  }


  void setSelectedMaterial(String value) {
    selectedMaterial = value;
    update() ;
  }

  void setFromPrice(int value) {
    fromprice = value;
    update() ;
  }

  void setToPrice(int value) {
    toprice = value;
    update() ;
  }

  void set_gift_party(var value) {
    if(value.toString().isEmpty)
      Gift_party = " " ;
    else Gift_party = value;
    update() ;

  }

  String? validate_to() {
    if (fromprice > toprice) {
      return "غير صالح";
    }
    return null;
  }



  @override
  void onInit() {
    super.onInit();
    fetch_material() ;

  }

  Future<void> fetch_material()async{
    final response = await http.get(Uri.parse('${MyApp.api}/api/All_material')) ;

    if(response.statusCode == 200)
      {
        ShopNameModel material = ShopNameModel.fromJson(jsonDecode(response.body)) ;
        for(int i =0 ; i < material.data.length ; i++)
          {
            if(!Materiallist.containsKey(material.data.elementAt(i).name))
                Materiallist[ material.data.elementAt(i).name] = material.data.elementAt(i) ;
          }

      }

    isLoading.value = false ;

  }

  Future<void> suggestion_prodcut()async{

    var formdata = formstate.currentState ;
    var formdata2 = formstate2.currentState ;
    var formdata3 = formstate3.currentState ;
    var formdata4 = formstate4.currentState ;
    var formdata5 = formstate5.currentState ;
    var formdata6 = formstate6.currentState ;

    formdata!.save();
    formdata2!.save();
    formdata3!.save();
    formdata4!.save() ;
    formdata5!.save();

    isLoad.value = true ;
    final response = await http.get(Uri.parse('${MyApp.api}/api/Gift_request/${Gift_party}/${selectedAge}/${selectedMaterial}/${fromprice}/${toprice}')) ;
    if(response.statusCode == 200)
    {
      ProductModel pr = ProductModel.fromJson(jsonDecode(response.body)) ;
      products.assignAll(pr.data) ;
      Get.to(Seggestions(
          title: "الاقتراحات", products: products));

    }
    isLoad.value = false;
  }

}
