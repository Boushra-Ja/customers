
class CartsModel{

  List<Carts>data ;
  CartsModel({required this.data}) ;

  factory CartsModel.fromJson(Map<String , dynamic> json)
  {
    return CartsModel(
        data:List<Carts>.from(
            json['data'].map((p) =>
                Carts.fromJson(p)))
            .toList()
    ) ;
  }
}



class Carts {
 late  List<MyProducts> myProducts;
  late dynamic order_id , amount,created_at;
  int myamount=0;



 Carts({
   required this.order_id ,
   required this.amount
   ,required this.myProducts,
   required this.created_at
 });


   Carts.fromJson(Map<String , dynamic> json)
   {


     if (json['my_products'] != null) {
       myProducts = [];
       json['my_products'].forEach((v) {
         myProducts.add(new MyProducts.fromJson(v));
       });
     }
     order_id =json['order_id'].toString() ;
     amount = json['amount'].toString() ;
     created_at = json['created_at'].toString() ;



   }

 // Map<String, dynamic> toJson() {
 //   final Map<String, dynamic> data = new Map<String, dynamic>();
 //   data['order_id'] = this.order_id;
 //   data['amount'] = this.amount;
 //   // if (this.myProducts != null) {
 //   //   data['my_products'] = this.myProducts.map((v) => v.toJson()).toList();
 //   // }
 //   return data;
 // }

}




class MyProducts {
 late int productId;
 int isradio=0;
 late String productName;
 late String image;
 late  int sellingPrice;
 late  int storeId;
 late  String storeName;
 late int numSallingStore;
 late var cost_price,
     num_cell,
     all_review,
     value_discount,
     all_reviews;
 int review =  0;
 int reviews =  0;




 MyProducts(
      {required this.productId,
        required this.productName,
        required  this.image,
        required  this.sellingPrice,
        required  this.storeId,
        required  this.cost_price,
        required  this.num_cell,
        required  this.all_review,
        required  this.storeName,
        required  this.all_reviews,
        required  this.value_discount,
        required this.numSallingStore});

   MyProducts.fromJson(Map<String , dynamic> json){


     cost_price= json['selling_price'] ;
     num_cell=json['num_cell'] ;
     all_review=json['review'];
     all_reviews=json['reviews'];
     value_discount=json['value_discount'];
     productId = json['product_id'];
     productName = json['product_name'];
     image = json['image'];
     sellingPrice = json['selling_price'];
     storeId = json['store_id'];
     storeName = json['store_name'];
     numSallingStore = json['num_salling_store'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    data['selling_price'] = this.sellingPrice;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['num_salling_store'] = this.numSallingStore;
    return data;
  }}