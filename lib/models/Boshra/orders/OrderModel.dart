

class Order{

  var store_id  ,order_id ,discount_codes_id , status_id;
  String  customer_name , created_at ,store_name , store_image   , delivery_time;


  factory Order.fromJson(Map<String , dynamic> json)
  {
    return Order(store_id : json['store_id'] , customer_name : json['customer_name'] ,
        order_id : json['order_id'] ,created_at : json['created_at'] , store_name : json['store_name']
        ,store_image : json['store_image'] , discount_codes_id : json['discount_codes_id'] , status_id:json['status_id'] , delivery_time:json['delivery_time']);
  }

  Order({required this.store_id , required this.customer_name , required this.order_id , required this.created_at , required this.store_name , required this.store_image , required this.discount_codes_id , required this.status_id , required this.delivery_time});

}


class OrderModel{

  List<Order>data ;
  OrderModel({required this.data}) ;

  factory OrderModel.fromJson(Map<String , dynamic> json)
  {
    return OrderModel(
        data:List<Order>.from(json['data'].map((p)=>Order.fromJson(p))).toList()
    ) ;
  }
}