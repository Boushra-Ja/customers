import 'package:get/get.dart';

import '../controllers/cart/TreatBasketController.dart';


class TreatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TreatBasketController());
  }}