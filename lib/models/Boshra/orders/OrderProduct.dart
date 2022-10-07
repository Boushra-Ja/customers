

import 'dart:collection';

import '../products/Option.dart';

class OrderProduct{

  int product_id   , store_id   , order_id , order_product_id , status_id;
  String store_name , store_image , delivery_time , order_time , product_name , product_image;
  var gift_order , amount ;
  Map<String , List<Option>> options = HashMap() ;
  List<int> selected_values = [];
  List<String> selected_option = [];
  List<int>opt_prod_ids = [] ;

  factory OrderProduct.fromJson(Map<String , dynamic> json)
  {
    return OrderProduct(order_product_id : json['order_product_id'] ,order_id : json['order_id']  ,
        product_id : json['product_id'] , store_id : json['store_id'] ,
        store_name : json['store_name'] , store_image:json['store_image'] ,
        delivery_time:json['delivery_time'] ,order_time:json['order_time'] ,
        product_name: json['product_name'] , product_image: json['product_image'] ,
        gift_order: json['gift_order'] , amount: json['amount'] , status_id:json['status_id']);
  }

  OrderProduct({required this.order_product_id , required this.order_id ,
    required this.product_id , required this.store_id ,
    required this.store_name , required this.store_image ,
    required this.delivery_time , required  this.order_time ,
    required this.product_name , required this.product_image ,
    required this.gift_order , required this.amount , required this.status_id });

}


class OrderProductModel{

  List<OrderProduct>data ;
  OrderProductModel({required this.data}) ;

  factory OrderProductModel.fromJson(Map<String , dynamic> json)
  {
    return OrderProductModel(
        data:List<OrderProduct>.from(json['data'].map((p)=>OrderProduct.fromJson(p))).toList()
    ) ;
  }

}