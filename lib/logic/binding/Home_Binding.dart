import 'package:get/get.dart';

import '../controllers/AppBarController.dart';
import '../controllers/HomePageController.dart';
import '../controllers/products/ProductController.dart';
class HomeBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => AppBarController(),fenix: true);
    Get.lazyPut(() => ProductController());




  }}