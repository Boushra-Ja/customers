

import '../../../view/Products.dart';
import 'RatingModel.dart';

class Shop {

  var id , shop_name , discription  ,image  , mobile , email , facebook ,num_of_salling ,all_review , area , brand;
  List<Product>all_products = [];
  int review =  0;
  bool isFavourite = false , isRating = false;


  factory Shop.fromJson(Map<String , dynamic> json)
  {

    return Shop(id : json['store_id'] ,shop_name: json['shop_name'],discription: json['discription'],image: json['image']
        ,mobile: json['mobile'] ,email: json['email'] , facebook: json['facebook'] ,num_of_salling: json['num_cell'],
        all_review: json['review'] , review:json['rate'] , area:json['delivery_area'] , brand:json['brand']);
  }

  Shop({required this.id , required this.shop_name,required this.discription, required this.image,  required this.mobile,
    required this.email,required this.facebook,required this.num_of_salling , required this.all_review , required this.review  ,required this.area , required this.brand});


}

class ShopModel{

  List<Shop>data ;
  ShopModel({required this.data}) ;

  factory ShopModel.fromJson(Map<String , dynamic> json)
  {
    return ShopModel(
        data:List<Shop>.from(json['data'].map((p)=>Shop.fromJson(p))).toList()
    ) ;
  }
}