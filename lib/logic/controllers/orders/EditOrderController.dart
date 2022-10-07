import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../../models/Boshra/orders/OrderProduct.dart';
import '../../../models/Boshra/products/Option.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditOrderController extends GetxController{

  int order_id , status_id ;
  var isLoading = true.obs , token ;
  List<OrderProduct> order_products = <OrderProduct>[].obs ;
  List<GlobalKey<FormState>> formstate = <GlobalKey<FormState>>[];
  final storage=const FlutterSecureStorage();

  void set_quantity(val , ind){
    order_products.elementAt(ind).amount = val ;
    update();
  }
  void setchexkboxValue(String val , ind){
    order_products.elementAt(ind).gift_order = val ;
    update();
  }
  Future<void> fetch_order_products()async{

    final response = await http.get(Uri.parse(
        '${MyApp.api}/api/all_orderproduct/${order_id}'), headers: {'Content-Type': 'application/json',
      'Accept': 'application/json', 'Authorization': 'Bearer $token'},);
    if (response.statusCode == 200) {
      OrderProductModel orderProductModel = OrderProductModel.fromJson(jsonDecode(response.body));
      order_products.assignAll(orderProductModel.data) ;

      for(int i = 0 ; i < order_products.length ; i++)
        {
          await get_all_options(i , order_products.elementAt(i).product_id) ;
          await fetchOptions_selected(order_products.elementAt(i).order_product_id , i) ;
        }
    }
    else
      print("error");

    for(int i =0 ; i < order_products.length ; i++)
        formstate.insert(i, new GlobalKey()) ;

    isLoading.value = false ;

  }

  EditOrderController(this.order_id , this.status_id ) ;

  void change_value(var val , int order_product_id , int index , int i ) {
    order_products.elementAt(i).selected_values[index] = val.value_id;

  }

  Future<void> fetchOptions_selected(int order_product_id , int i) async {

      final response = await http.get(Uri.parse(
          '${MyApp.api}/api/order_product/options/${order_product_id}'),headers: {'Content-Type': 'application/json',
        'Accept': 'application/json', 'Authorization': 'Bearer $token'},);
      if (response.statusCode == 200) {
        OptionModel optionModel = OptionModel.fromJson(jsonDecode(response.body));

        for(int k =  0 ; k < optionModel.data.length ; k++)
        {
          order_products.elementAt(i).selected_values.add(optionModel.data[k].value_id);
          order_products.elementAt(i).selected_option.add(optionModel.data[k].value);
          order_products.elementAt(i).opt_prod_ids.add(optionModel.data[k].product_options_id);
        }
      }

  }

  Future<void> get_all_options(int i , product_id) async {

    Map <String, List<Option>>temp = new HashMap();

      temp = new HashMap<String, List<Option>>();
      final response = await http.get(Uri.parse(
          '${MyApp.api}/api/option_for_product/${product_id}') , );
      if (response.statusCode == 200) {
        OptionModel optionModel = OptionModel.fromJson(
            jsonDecode(response.body));

        for (int j = 0; j < optionModel.data.length; j++) {
          if (temp.containsKey(optionModel.data[j].name)) {
            temp['${optionModel.data[j].name}']?.add(optionModel.data[j]);
          }
          else {
            temp['${optionModel.data[j].name}'] = [optionModel.data[j]];
          }
        }
        order_products[i].options = temp ;

      }
        print(order_products[i].options);
  }

  Future<void> edit_options(int order_product_id , int i)async{

      for(int j = 0 ; j < order_products.elementAt(i).opt_prod_ids.length ; j++)
      {
        final response = await http.post(
            Uri.parse('${MyApp.api}/api/edit/option_product/${order_products.elementAt(i).opt_prod_ids.elementAt(j)}'),
            headers: {'Content-Type': 'application/json',
              'Accept': 'application/json', 'Authorization': 'Bearer $token'},
            body: jsonEncode(<String, dynamic>{
              'option_values_id' : order_products.elementAt(i).selected_values.elementAt(j)
            }));

        if(response.statusCode == 200)
          {
            print('success22') ;
          }
      }
  }

  Future<void> delete_product(int order_prod_id)async{


    final response = await http.delete(
      Uri.parse('${MyApp.api}/api/delete/wating_order/$order_prod_id'),headers: {'Content-Type': 'application/json',
      'Accept': 'application/json', 'Authorization': 'Bearer $token'},);

    if(response.statusCode == 200)
    {
      print('success') ;
      Get.snackbar("تم حذف الطلب", "قم بتحديث الصفحة..") ;
    }
  }

  Future<void> edit_order_product(int ind)async{

    var formdate = formstate.elementAt(ind).currentState ;
    if(formdate!.validate())
      formdate.save() ;

    final response = await http.post(
        Uri.parse('${MyApp.api}/api/edit/order_product'),
        headers: {'Content-Type': 'application/json',
          'Accept': 'application/json', 'Authorization': 'Bearer $token'},
        body: jsonEncode(<String, dynamic>{
          'product_id' : order_products.elementAt(ind).product_id,
          'order_id' :order_products.elementAt(ind).order_id ,
          'amount' :  order_products.elementAt(ind).amount ,
          'gift_order' :  order_products.elementAt(ind).gift_order
        }));

    if(response.statusCode == 200)
      {
         edit_options(int.parse(response.body) , ind) ;
         Get.snackbar("تم تعديل الطلب", "") ;
      }

  }

  @override
  void onInit() async{
    token  = await storage.read(key: 'token') ;
    super.onInit();
    await fetch_order_products() ;
  }
}