import 'dart:convert';

import 'package:get/get.dart';

import '../../../main.dart';
import 'package:http/http.dart' as http;

import '../../../models/Boshra/Store/RatingProfile.dart';

class RatingProfileController extends GetxController{

  var stote_id  , isLoading = false.obs ;
  late RatingProfile info ;


  RatingProfileController(this.stote_id) ;

  Future<void>fetchProfile()async{
    final response = await http.get(
        Uri.parse('${MyApp.api}/api/store/profile/rating/${stote_id}}'),
        headers: {'Content-Type': 'application/json',
          'Accept': 'application/json',});

    if(response.statusCode == 200)
      {
        print('success') ;
        RatingProfileModel ratingProfileModel = RatingProfileModel.fromJson(jsonDecode(response.body)) ;
        info = ratingProfileModel.data[0] ;

      }

    isLoading.value = true ;


  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile() ;
  }

}