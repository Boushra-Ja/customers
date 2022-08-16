

class Bill{

  int order_id , customer_id ,store_id ,order_product_id ,product_id  ,selling_price , discount_value , discount_customer_value;
  String store_name,  store_image , delivery_time ,customer_name  , product_name  , amount ;


  factory Bill.fromJson(Map<String , dynamic> json)
  {
    return Bill(store_id : json['store_id'] , customer_id : json['customer_id'] ,
        order_id : json['order_id']   , order_product_id : json['order_product_id'] ,
        product_id : json['product_id'] , selling_price : json['selling_price'] ,
        discount_value : json['discount_value'] , store_name : json['store_name'] ,
        store_image : json['store_image'] ,  delivery_time : json['delivery_time'] , customer_name : json['customer_name'] ,
        product_name : json['product_name'] , amount:json['amount'] , discount_customer_value:json['discount_customer_value']
    );
  }

  Bill({required this.store_id , required this.customer_id , required this.order_id  ,
    required this.order_product_id , required this.product_id , required this.selling_price
    ,required this.discount_value , required this.store_name , required this.store_image ,
    required this.delivery_time , required this.customer_name , required this.product_name , required this.amount,required this.discount_customer_value
  });

}


class BillModel{

  List<Bill>data ;
  BillModel({required this.data}) ;

  factory BillModel.fromJson(Map<String , dynamic> json)
  {
    return BillModel(
        data:List<Bill>.from(json['data'].map((p)=>Bill.fromJson(p))).toList()
    ) ;
  }
}