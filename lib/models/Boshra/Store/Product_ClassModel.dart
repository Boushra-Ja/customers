
class Product_Class {
///id is product_id
  var id , product_name  ,image  , selling_price , collection_id , secondary_id ,
      classifications_title ,classification_id , secondray_title , class_product_id , isFavourite = false;



  factory Product_Class.fromJson(Map<String , dynamic> json)
  {

    return Product_Class(id : json['product_id'] ,product_name: json['product_name'],image: json['image'],selling_price: json['selling_price'],
        collection_id: json['collection_id'] ,secondary_id: json['secondary_id'] , classifications_title: json['classifications_title']
        ,classification_id: json['classification_id'], secondray_title: json['secondray_title'] , class_product_id:json['class_product_id']);
  }

  Product_Class({required this.id , required this.product_name,required this.image,required this.selling_price,   required this.collection_id,
    required this.secondary_id,required this.classifications_title,required this.classification_id , required this.secondray_title , required this.class_product_id });
}

class Product_ClassModel{

  List<Product_Class>data ;
  Product_ClassModel({required this.data}) ;

  factory Product_ClassModel.fromJson(Map<String , dynamic> json)
  {
    return Product_ClassModel(
        data:List<Product_Class>.from(json['data'].map((p)=>Product_Class.fromJson(p))).toList()
    ) ;
  }
}