import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../../models/Boshra/orders/DiscountModel.dart';
import '../../../models/Boshra/orders/OrderModel.dart';
import '../../../models/Boshra/orders/OrderProduct.dart';
import '../orders/ShoppingBasket.dart';

class TreatBasketController extends GetxController {
  List<ShoppingBasket> maplist = [];
  final storage = const FlutterSecureStorage();
  var user_id, token;
  var chexkboxValue = [].obs;
  var total_price = 0 ;
  var selected_discount_id = 0 ;

  ///boshra
  var isApplied = false.obs;

  var isLoading = false, cnt = 0.obs, isAdd = true;

  var code;
  List<DiscountCode> discount_list = <DiscountCode>[].obs;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  void setchexkboxValue(bool val, int id) {
    chexkboxValue.value[id] = val;
    update();
  }

  Future<void> AddOrder() async {
    isAdd = false;
    update();
    int id = int.parse(user_id);


    var response = await http.post(Uri.parse('${MyApp.api}/api/orders'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          "store_id": maplist.elementAt(0).store_id,
          "delivery_time": maplist.elementAt(0).delivery_time,
          "delivery_price": total_price,
          "customer_id": id,
        }));

    if (response.statusCode == 200) {
      cnt.value++;
      update();
      OrderModel orderModel = OrderModel.fromJson(jsonDecode(response.body));
      maplist[0].order_id = orderModel.data[0].order_id;
      if(selected_discount_id != 0)
      {
        var response2 = await http.post(Uri.parse('${MyApp.api}/api/apply_disount/${maplist[0].order_id}'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode(<String, dynamic>{
              "discount_codes_id": selected_discount_id,
            }));
        if(response2.statusCode == 200)
        {
          print("success in apply discount") ;
        }

      }
      print("success1");
    } else
      print("error");
  }

  Future<void> AddOrderProduct(
      {required product_id,
        required order_id,
        required amount,
        required gift_order,
        required ind}) async {
    var response = await http.post(Uri.parse('${MyApp.api}/api/order_product'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          "product_id": product_id,
          "order_id": order_id,
          "amount": amount,
          "gift_order": gift_order,
        }));

    if (response.statusCode == 200) {
      cnt.value++;
      update();
      OrderProductModel orderProductModel =
      OrderProductModel.fromJson(jsonDecode(response.body));
      maplist.elementAt(ind).order_prodcut_id =
          orderProductModel.data[0].order_product_id;
      print("success2");
    } else
      print("eroorr");
  }

  ///boshra
  Future<void> storage_options(int ind) async {

    for (int i = 0; i < maplist.elementAt(ind).selected_values.length; i++) {
      final response =
      await http.post(Uri.parse('${MyApp.api}/api/option_product'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, int>{
            "order_product_id": maplist.elementAt(ind).order_prodcut_id,
            "option_values_id":
            maplist.elementAt(ind).selected_values.elementAt(i),
          }));

      if (response.statusCode == 200) {
        print("successssssssssss");
      }
    }
  }

  ///boshra
  Future<void> deleteFromBasket(var store_id, var product_id) async {
    String? stringofitems = await storage.read(key: 'basket');
    List<dynamic> listofitems = jsonDecode(stringofitems!);

    List<dynamic> temp = [];
    for (int i = 0; i < listofitems.length; i++) {
      ShoppingBasket model =
      ShoppingBasket.fromJson(jsonDecode(listofitems.elementAt(i)));

      if (model.store_id == store_id && model.product_id == product_id)
        continue;
      else
        temp.add(listofitems.elementAt(i));
    }
    print(temp);
    await storage.write(key: 'basket', value: jsonEncode(temp));
    update();
  }

  ///boshra
  void set_applied(val, ind) {
    discount_list.elementAt(ind).isApplied = val;
    update();
  }

  ///boshra
  void set_code(val) {
    code = val;
    update();
  }

  ///boshra
  Future<void> fetch_discounts() async {
    user_id = await storage.read(key: 'id');

    final response = await http.get(
      Uri.parse(
          '${MyApp.api}/api/discount_store/${user_id}/${maplist.elementAt(0).store_id}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      DiscountCodeModel discountCodeModel =
      DiscountCodeModel.fromJson(jsonDecode(response.body));
      discount_list.assignAll(discountCodeModel.data);
    }
    for (int i = 0; i < maplist.length; i++) {
      chexkboxValue.insert(i, false);
    }

    isLoading = true;
    update();
  }

  ///boshra
  Future<void> apply_discount(var ind) async {
    selected_discount_id = discount_list.elementAt(ind).discount_codes_id ;


    total_price =
        ( total_price - (total_price * discount_list.elementAt(ind).value / 100)).toInt();

    print('2total_price  $total_price');
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();

      delete_discount(ind);
      discount_list.elementAt(ind).isApplied = false;
      discount_list.elementAt(ind).check_ = true;
      update();
    }
  }

  ///boshra
  Future<void> delete_discount(int ind) async {
    print(discount_list.elementAt(ind).discount_customer_id.runtimeType);
    final response = await http.delete(
      Uri.parse(
          '${MyApp.api}/api/delete_discount/${discount_list.elementAt(ind).discount_customer_id}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      print('success delete');
    }
  }

  ///boshra
  void set_isAdd(var val) {
    isAdd = val;
    update();
  }

  @override
  void onInit() async {
    maplist = Get.arguments["map"];
    user_id = await storage.read(key: 'id');
    token = await storage.read(key: 'token');
    fetch_discounts();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
