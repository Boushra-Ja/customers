

class DiscountCode{

  int discount_codes_id , discounts_id ,value ,store_id ,discount_customer_id  ;
  String start_date,  end_date , discount_code  , store_name ;
  var isApplied = false  , check_ = false ;

  factory DiscountCode.fromJson(Map<String , dynamic> json)
  {
    return DiscountCode(discount_codes_id : json['discount_codes_id'] , discounts_id : json['discounts_id'] ,
        value : json['value']   , store_id : json['store_id'] ,
        discount_customer_id : json['discount_customer_id'] , start_date : json['start_date'] ,
        end_date : json['end_date'] , store_name : json['store_name'] ,
        discount_code : json['discount_code']
    );
  }

  DiscountCode({required this.discount_codes_id , required this.discounts_id , required this.value  ,
    required this.store_id , required this.discount_customer_id , required this.start_date
    ,required this.end_date , required this.store_name , required this.discount_code ,
  });

}


class DiscountCodeModel{

  List<DiscountCode>data ;
  DiscountCodeModel({required this.data}) ;

  factory DiscountCodeModel.fromJson(Map<String , dynamic> json)
  {
    return DiscountCodeModel(
        data:List<DiscountCode>.from(json['data'].map((p)=>DiscountCode.fromJson(p))).toList()
    ) ;
  }
}