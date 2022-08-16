


import 'dart:convert';

//Favorite_product2Model fFromJson(String str) => Favorite_product2Model.fromJson(json.decode(str));

class Favorite_product2Model{

  List<Favorite_product2>data ;
  Favorite_product2Model({required this.data}) ;

  factory Favorite_product2Model.fromJson(Map<String , dynamic> json)
  {
    return Favorite_product2Model(
        data:List<Favorite_product2>.from(json['data'].map((p)=>Favorite_product2.fromJson(p)))
    ) ;
  }
}



class Favorite_product2 {
   late int id;
   late int product_id;




  Favorite_product2(
      {
        required this.id,
        required this.product_id,



      });

  Favorite_product2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product_id = json['product_id'];




  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['product_id'] = this.product_id;
    data['id'] = this.id;

    return data;
  }
}