import 'package:get/get.dart';

import '../controllers/FavoriteController.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => FavoriteController());


  }}