
class productsModel{

  List<products>data ;
  productsModel({required this.data}) ;

  factory productsModel.fromJson(Map<String , dynamic> json)
  {
    return productsModel(
        data:List<products>.from(json['data'].map((p)=>products.fromJson(p)))
    ) ;
  }
}



class products {
  late var id;
  late var image;
  late  var product_name;
  late  var rating;
  late var selling_price;
  late var costPrice;
  late var numberOfSales;

   bool isFavourite =false;
   int count_0=0,count_1=0,count_2=0;

  products(
      {
        required this.id,
        required  this.image,
        required  this.product_name,
        required  this.selling_price,
        required  this.costPrice,
        required  this.numberOfSales,
        required  this.rating,


        });

  products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    rating = json['rating'];
    product_name = json['name'];//product_name
    selling_price = json['selling_price'];
    costPrice = json['cost_price'];
    numberOfSales = json['number_of_sales'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['name'] = this.product_name;
    data['selling_price'] = this.selling_price;
    data['cost_price'] = this.costPrice;
    data['number_of_sales'] = this.numberOfSales;

    return data;
  }
}