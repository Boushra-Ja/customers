import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../main.dart';
import '../../../models/Boshra/Store/ShopModel.dart';

class ShopPageController extends GetxController {

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  var search_name = " " ;
  RxString selectedsortvalue = "جميع المتاجر".obs ;
  var items = [
    "جميع المتاجر" ,
    "الأكثر مبيعا",
    "الأفضل تقييما",
  ];

  List<Shop> ShopList = <Shop>[].obs ;
  var isLoading = true.obs ;


  @override
  void onInit() {
    super.onInit();
    fetchALlStores() ;
  }


  Future<void>fetchALlStores()async{
    final response = await http.get(Uri.parse('${MyApp.api}/api/stores')) ;

    if(response.statusCode == 200)
      {

        ShopModel shopModel = ShopModel.fromJson(jsonDecode(response.body)) ;
        ShopList.assignAll(shopModel.data );

        isLoading.value = false;


      }else{
      print("errorrrrr") ;
    }
  }

  Future<void>StoresMoreSales()async{
    final response = await http.get(Uri.parse('${MyApp.api}/api/stores/order/sales')) ;
    if(response.statusCode == 200)
    {
      ShopModel shopModel = ShopModel.fromJson(jsonDecode(response.body)) ;
      ShopList.assignAll(shopModel.data );

      isLoading.value = false ;

    }else{
      print("errorrrrr") ;
    }
  }

  Future<void>StoresMoreReview()async{
    final response = await http.get(Uri.parse('${MyApp.api}/api/stores/order/reviews')) ;
    if(response.statusCode == 200)
    {
      ShopModel shopModel = ShopModel.fromJson(jsonDecode(response.body)) ;

      ShopList.assignAll(shopModel.data );

      isLoading.value = false ;
    }else{
      print("errorrrrr") ;
    }
  }

  void setselectedvalue(var val)
  {
    selectedsortvalue  = val ;
  }

  String? validate_value(String val) {
    if (val == "") {
      return ' مطلوب';
    }
    return null;
  }

  Future<void>search_stores()async{
    final response = await http.get(Uri.parse('${MyApp.api}/api/search/store/${search_name}')) ;

    if(response.statusCode == 200)
    {

      ShopModel shopModel = ShopModel.fromJson(jsonDecode(response.body)) ;
      ShopList.assignAll(shopModel.data );

      isLoading.value = false;


    }else{
      print("errorrrrr") ;
    }
  }
}