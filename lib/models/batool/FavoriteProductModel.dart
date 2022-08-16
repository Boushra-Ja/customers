//
//
// class Favorite_productModel{
//
//   List<Favorite_product>data ;
//   Favorite_productModel({required this.data}) ;
//
//   factory Favorite_productModel.fromJson(Map<String , dynamic> json)
//   {
//     return Favorite_productModel(
//         data:List<Favorite_product>.from(json['data'].map((p)=>Favorite_product.fromJson(p)))
//     ) ;
//   }
// }
//
//
//
// class Favorite_product {
//   late int id;
//   late String image ;
//   late String name;
//   late int product_id;
//   late int value;
//
//
//
//   Favorite_product(
//       {
//         required this.id,
//         required this.value,
//         required this.name,
//         required this.product_id,
//         required this.image,
//
//
//       });
//
//   Favorite_product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     value = json['value'];
//     name = json['name'];
//     image = json['image'];
//     product_id = json['product_id'];
//
//     // selling_price = json['title'];
//     // return_or_replace = json['title'];
//     // discription = json['title'];
//     // discount_products_id = json['title'];
//     // number_of_sales = json['title'];
//     // notes = json['title'];
//     //
//     // party = json['title'];
//     // prepration_time = json['title'];
//     // product_id = json['title'];
//     // customer_id = json['title'];
//     // collection_id = json['title'];
//     // age = json['title'];
//     // cost_price = json['title'];
//     // gift = json['classification_id'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//
//     // data['title'] = this.cost_price;
//     // data['title'] = this.age;
//     // data['title'] = this.collection_id;
//     // data['title'] = this.customer_id;
//     // data['title'] = this.product_id;
//     // data['title'] = this.prepration_time;
//     // data['title'] = this.party;
//     // data['title'] = this.discription;
//     // data['title'] = this.notes;
//     // data['title'] = this.number_of_sales;
//     // data['title'] = this.discount_products_id;
//     // data['title'] = this.return_or_replace;
//     // data['title'] = this.selling_price;
//     // data['classification_id'] = this.gift;
//     data['name'] = this.name;
//     data['product_id'] = this.product_id;
//     data['id'] = this.id;
//     data['image'] = this.image;
//     data['value'] = this.value;
//
//     return data;
//   }
// }