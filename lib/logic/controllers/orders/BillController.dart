
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';
import '../../../models/Boshra/orders/BillModel.dart';
import '../../../models/Boshra/orders/OrderProduct.dart';

class BillController extends GetxController{

  int order_id ;
  BillController( this.order_id) ;
  var isLoading = true.obs;
  var total_price = 0 , token;
  var price_after_discount = 0.0 ;
  final storage=const FlutterSecureStorage();

  List<Bill> products_bill = <Bill>[].obs;

  Future<void> fetch_bill()async{

    print(order_id) ;
    final response = await http.get(Uri.parse('${MyApp.api}/api/bill/${order_id}'), headers: {'Content-Type': 'application/json',
      'Accept': 'application/json', 'Authorization': 'Bearer $token'},) ;

    if(response.statusCode == 200 ) {
      BillModel orderModel = BillModel.fromJson(jsonDecode(response.body));
      products_bill.assignAll(orderModel.data) ;

      for(int i = 0 ;i < products_bill.length ; i++)
        {
          ////يجب ضربه بالكمية
          total_price += (products_bill.elementAt(i).selling_price * int.parse(products_bill.elementAt(i).amount));
          if(products_bill.elementAt(i).discount_value != 0)
             price_after_discount += (products_bill.elementAt(i).selling_price - (products_bill.elementAt(i).selling_price* products_bill.elementAt(i).discount_value)/100);

          else
            price_after_discount = total_price/1.0 ;
        }
      print(price_after_discount) ;
      isLoading.value = false;
    }

  }


  @override
  void onInit() async{
    super.onInit();
    token =  await storage.read(key: 'token') ;
    await fetch_bill() ;
  }

}