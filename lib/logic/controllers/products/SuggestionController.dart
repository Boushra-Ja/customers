import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';

class SuggestionController extends GetxController{
  final storage=const FlutterSecureStorage();
  var user_id , token;
  List<dynamic>products;

  SuggestionController(this.products) ;

  Future<void> addToFavouriteProduct(int product_id , int ind)async {
    user_id  = await storage.read(key: 'id') ;
    token  = await storage.read(key: 'token') ;

    final response = await http.post(
        Uri.parse('${MyApp.api}/api/FavoriteProduct/Add_Favorite/${product_id}'),
        headers: {'Content-Type': 'application/json',
          'Accept': 'application/json', 'Authorization': 'Bearer $token'},
        body: jsonEncode(<String, dynamic>{
          "customer_id": user_id,
        }));

    print(response.body) ;
    if(response.body=="add_to_favorite")
    {
      products.elementAt(ind).isFavourite = true;
      print("add") ;
      update() ;
    }
    else {
      products.elementAt(ind).isFavourite = false;
      print("remove") ;
      update() ;
    }

  }


}