import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import '../../../main.dart';
import '../../../models/Boshra/orders/OrderProduct.dart';
import '../../../models/Boshra/products/Option.dart';
import '../../../models/Boshra/products/ProductModel.dart';
import '../orders/ShoppingBasket.dart';


class ProductDeatilController extends GetxController{

  late Product product ;
  var product_id  , isLoading = true.obs , loading_option = true.obs , loading_page = true.obs ;
  var chexkboxValue = "".obs , token;
  var report_of_product = '' , user_id ;
  var size_list = 4.obs  , counter = 1.obs;
  int count = 0  ;
  int order_product_id =  0 ;
  List<int>selected_values = [];
  final storage=const FlutterSecureStorage();

  ProductDeatilController(this.product_id) ;

  void increment_size(){
    int difference = product.all_review.length - (counter*4) ;
    if(difference  > 0)
    {
      if(difference - 4 > 0 )
      {
        size_list+= 4 ;
        difference-= 4 ;
      }
      else{
        size_list+= difference ;
      }

    }
    counter++ ;

  }

  void setchexkboxValue(String val){
    chexkboxValue.value = val ;
  }

  void set_reportofproduct(String val){
    report_of_product  = val ;
    update() ;
  }

  void change_selectvalue(int index , var val) {
    selected_values[index] = val;
    update();
  }

  String? validate_value(String val) {
    if (val == "") {
      return ' مطلوب';
    }
    return null;
  }

  String? validate_reportofproduct(String val) {
    if (val == "") {
      return ' مطلوب';
    }
    return null;
  }

  Future<void> fetchProductInfo(var id)async{
    final response = await http.get(Uri.parse('${MyApp.api}/api/products/$id')) ;
    final response2= await http.get(Uri.parse('${MyApp.api}/api/similar_products/$id')) ;
    ///customer_id
    final favourite = await http.get(Uri.parse('${MyApp.api}/api/isFavourite/product/$id/${user_id}'),headers: {'Content-Type': 'application/json',
      'Accept': 'application/json', 'Authorization': 'Bearer $token'},) ;

    if(response.statusCode == 200 && response2.statusCode == 200 && favourite.statusCode == 200)
    {
      ProductModel productModel = ProductModel.fromJson(jsonDecode(response.body)) ;
      ProductModel productModel2 = ProductModel.fromJson(jsonDecode(response2.body)) ;

      product = Product(id: productModel.data[0].id, product_name: productModel.data[0].product_name,
          discription: productModel.data[0].discription, image: productModel.data[0].image,
          selling_price: productModel.data[0].selling_price, num_cell: productModel.data[0].num_cell,
          prepration_time: productModel.data[0].prepration_time, return_or_replace: productModel.data[0].return_or_replace ,
          store_id:productModel.data[0].store_id ,store_name:productModel.data[0].store_name ,
          salling_store:productModel.data[0].salling_store , all_review: productModel.data[0].all_review , similar_product: productModel2.data , discount_id: productModel.data[0].discount_id ,
          discount_value: productModel.data[0].discount_value , store_image: productModel.data[0].store_image)   ;

      for(int i = 0 ;  i < product.similar_product.length ; i++)
      {
        ///customer_id
        final favourite_similar = await http.get(Uri.parse('${MyApp.api}/api/isFavourite/product/${product.similar_product[i].id}/$user_id'),
          headers: {'Content-Type': 'application/json',
            'Accept': 'application/json', 'Authorization': 'Bearer $token'},) ;
        if(favourite_similar.body == "1")
          product.similar_product[i].isFavourite = true ;
        else
          product.similar_product[i].isFavourite = false ;
      }

      isBasket() ;
      await get_options(id) ;

      if(favourite.body=="1")
        product.isFavourite = true ;
      else
        product.isFavourite = false;

      await isRating() ;
      isLoading.value = false ;

    }else{
      print("errorrrrr") ;
    }

  }

  Future<void> get_options(var id)async{
    final response= await http.get(Uri.parse('${MyApp.api}/api/option_for_product/$id')) ;
    if(response.statusCode == 200) {
      OptionModel optionModel = OptionModel.fromJson(jsonDecode(response.body)) ;

      for(int  i = 0 ; i < optionModel.data.length ; i++)
      {
        if(product.options.containsKey(optionModel.data[i].name))
        {
          product.options['${optionModel.data[i].name}']?.add(optionModel.data[i]);

        }
        else{
          product.options['${optionModel.data[i].name}'] =  [optionModel.data[i]] ;
          selected_values.add(optionModel.data[i].value_id) ;
        }
      }
      print(product.options) ;

    }
  }


  Future<void> addToFavouriteProduct(int product_id , int ind)async {

    ///ind من اجل معرفة هل هو لتعديل المنتج نفسه ام لتعديل احد المنجات المشابهة
    final response = await http.post(
        Uri.parse('${MyApp.api}/api/FavoriteProduct/Add_Favorite/${product_id}'),
        headers: {'Content-Type': 'application/json',
          'Accept': 'application/json', 'Authorization': 'Bearer $token'},
        body: jsonEncode(<String, dynamic>{
          "customer_id": user_id,
        }));

    if(response.body=="add_to_favorite")
    {
      if(ind == -1)
        product.isFavourite = true;
      else
        product.similar_product[ind].isFavourite = true ;

      print("add") ;
      update() ;
    }
    else {
      if(ind == -1)
        product.isFavourite = false;
      else
        product.similar_product[ind].isFavourite = false ;

      print("remove") ;
      update() ;
    }

  }

  Future<void> isRating()async{
    final response = await http.get(
      Uri.parse('${MyApp.api}/api/isRating/product/${product_id}/${user_id}') , headers: {'Content-Type': 'application/json',
      'Accept': 'application/json', 'Authorization': 'Bearer $token'},);
    if(response.statusCode == 200)
    {
      if(response.body =="1")
        product.isRating = true ;
      else
        product.isRating = false ;
      print(product.isRating) ;
      update() ;
    }
  }

  void deleteFromBasket()async{

    String? stringofitems = await storage.read(key: 'basket');
    List<dynamic> listofitems = jsonDecode(stringofitems!);

    List<dynamic> temp = [] ;
    for(int i = 0; i <listofitems.length ; i++)
    {
      ShoppingBasket model = ShoppingBasket.fromJson(jsonDecode(listofitems.elementAt(i)));

      if(model.store_id == product.store_id && model.product_id == product.id)
        continue ;
      else
        temp.add(listofitems.elementAt(i)) ;

    }
    print(temp) ;
    await storage.write(key: 'basket', value: jsonEncode(temp));
    product.is_basket = false ;
    update() ;
  }

  void addTo_Basket()async{

    ShoppingBasket orderProduct =  ShoppingBasket(product_id: product.id, store_id: product.store_id, store_name: product.store_name,
        store_image: product.store_image, delivery_time: "", order_time: "", product_name: product.product_name, product_image: product.image, gift_order: 'no', amount: 1 , selling_price: product.selling_price , discount_id: product.discount_id , discount_value: product.discount_value);

    var l = ShoppingBasket.serialize(orderProduct) ;

    String? stringofitems = await storage.read(key: 'basket');
    List<dynamic> listofitems = [];
    if(stringofitems != null)
    {
      listofitems = jsonDecode(stringofitems);
      listofitems.add(l) ;
    }
    else
    {
      listofitems.add(l) ;
    }

    await storage.write(key: 'basket', value: jsonEncode(listofitems));

    print(listofitems) ;
    product.is_basket = true;
    update() ;

  }

  void isBasket()async{

    String? stringofitems = await storage.read(key: 'basket');
    if(stringofitems==null)
      return ;

    List<dynamic> listofitems = jsonDecode(stringofitems);

    for(int i = 0; i <listofitems.length ; i++)
    {
      OrderProduct model = OrderProduct.fromJson(jsonDecode(listofitems.elementAt(i)));

      if(model.store_id == product.store_id && model.product_id == product.id)
      {
        product.is_basket = true ;
        break ;
      }
    }
  }

  @override
  void onInit() async{
    super.onInit();
    user_id  = await storage.read(key: 'id') ;
    token  = await storage.read(key: 'token') ;

    await fetchProductInfo(product_id) ;
  }
}