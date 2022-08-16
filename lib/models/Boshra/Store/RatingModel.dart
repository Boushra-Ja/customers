
class Rating {

  var  rating_id , customer_id  ,value  , notes ,created_at ,updated_at , customer_name;


  factory Rating.fromJson(Map<String , dynamic> json)
  {

    return Rating(rating_id: json['rating_id'],customer_id: json['customer_id'],value: json['value']
        ,notes: json['notes'] ,created_at: json['created_at'] ,updated_at: json['updated_at']  , customer_name:json['customer_name'][0]['name']);
  }

  Rating({required this.rating_id,required this.customer_id, required this.value,  this.notes,
    required this.created_at,required this.updated_at , required this.customer_name});

}
