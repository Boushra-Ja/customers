import 'package:get/get.dart';

import '../controllers/cart/CartController.dart';


class CartBinding extends  Bindings{
  @override
  void dependencies() {
    Get.put(CartController());
    }

}