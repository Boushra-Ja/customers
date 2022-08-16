
import 'dart:collection';

import 'Option.dart';

class Product {

  var id , product_name , discription  ,image  , selling_price  ,num_cell ,
      all_review  , prepration_time , return_or_replace , store_id , store_name ,
      salling_store , similar_product , discount_id , discount_value,store_image;
  int review =  0;
  bool is_basket = false , isFavourite = false , isRating = false ;
  Map<String , List<Option>> options = HashMap() ;

  factory Product.fromJson(Map<String , dynamic> json)
  {

    return Product(id : json['product_id'] ,product_name: json['product_name'],discription: json['discription'],image: json['image']
        ,selling_price: json['selling_price'] ,num_cell: json['num_cell'] , all_review:json['review'],
        prepration_time: json['prepration_time'] , return_or_replace: json['return_or_replace'] , store_id : json['store_id'] ,
        store_name : json['store_name'], salling_store:json['num_salling_store'] , discount_id:json['discount_id'] , discount_value: json['discount_value'],store_image: json['store_image']
        );
  }

  Product({required this.id , required this.product_name,required this.discription, required this.image,  required this.selling_price,
    required this.num_cell , required this.prepration_time, required this.return_or_replace ,required this.store_id , required this.store_name ,required this.salling_store , required this.all_review ,  this.similar_product , required this.discount_id ,required this.discount_value,required this.store_image});


}

class ProductModel{

  List<Product>data ;
  ProductModel({required this.data}) ;

  factory ProductModel.fromJson(Map<String , dynamic> json)
  {
    return ProductModel(
        data:List<Product>.from(json['data'].map((p)=>Product.fromJson(p))).toList()
    ) ;
  }
}