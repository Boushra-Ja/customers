import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';
import '../../../models/Boshra/products/Option.dart';
import '../orders/ShoppingBasket.dart';


class CartController extends GetxController {
  var counter = ''.obs;
  ///boshra
  int count = 0  ;
  String CartAmount = "";
  late TextEditingController CartAmountcontroller;

  var isLoading = false.obs ;
  var ListCArt = <ShoppingBasket>[];
  Map<int, List<ShoppingBasket>> map1 = {};
  var check = ''.obs;
  var IsNullBasket = ''.obs;


  ///boshra
  Future<void> get_options(var id, var store_id, int ind) async {

    final response =
        await http.get(Uri.parse('${MyApp.api}/api/option_for_product/$id'));
    if (response.statusCode == 200) {
      OptionModel optionModel = OptionModel.fromJson(jsonDecode(response.body));

      for (int i = 0; i < optionModel.data.length; i++) {
        if (map1[store_id]!
            .elementAt(ind)
            .options
            .containsKey(optionModel.data[i].name)) {
          map1[store_id]!
              .elementAt(ind)
              .options['${optionModel.data[i].name}']
              ?.add(optionModel.data[i]);
        } else {
          map1[store_id]!
              .elementAt(ind)
              .options['${optionModel.data[i].name}'] = [optionModel.data[i]];

          map1[store_id]!.elementAt(ind).selected_values.add(optionModel.data[i].value_id);
          map1[store_id]!.elementAt(ind).selected_option.add(optionModel.data[i].value);

        }
      }
    }
  }


  ///boshra
  void change_selectvalue(int index , var val , var value , var store_id , int i) {
    map1[store_id]!.elementAt(index).selected_values[i] = val;
    map1[store_id]!.elementAt(index).selected_option[i] = value ;
    update();
  }

  ///boshra
  String? validate_value(String val) {
    if (val == "") {
      return ' مطلوب';
    }
    return null;
  }

  String? selectedValue;
  String? selectedValue2;

  void onSelected(String value) async {
    selectedValue = value;
    print(selectedValue);
    update();
  }

  void onSelected2(String value) async {
    selectedValue2 = value;
    print(selectedValue2);
    update();
  }

  late List jsonResponse;

  List_Cart() async {
    IsNullBasket.value = await storage.read(key: 'basket') as String;

    String? stringofitems = await storage.read(key: 'basket');
    if (stringofitems != null) {
      List<dynamic> listofitems = jsonDecode(stringofitems);

      for (int i = 0; i < listofitems.length; i++) {
        ShoppingBasket model =
            ShoppingBasket.fromJson(jsonDecode(listofitems.elementAt(i)));


        model.selling_after_dis = model.discount_value != 0 ? (model.selling_price - (model.selling_price*model.discount_value/100)).toInt() : model.selling_price;


        if (map1.containsKey(model.store_id)) {
          map1[model.store_id]?.add(model);
          await get_options(model.product_id, model.store_id, map1[model.store_id]!.length-1);

        }
        else {
          map1[model.store_id] = [model];
          await get_options(model.product_id, model.store_id, 0);

        }
      }
    }

    isLoading.value = true ;
    update();
  }

  ///boshra
  void set_check(var ind ,var i )
  {
    map1.values.elementAt(ind)[i].gift_order='yes';
    update() ;


  }

  @override
  void onInit() async {
     await List_Cart();
  }
}
