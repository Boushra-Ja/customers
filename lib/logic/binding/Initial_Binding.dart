import 'package:get/get.dart';

import '../controllers/HomePageController.dart';
import '../controllers/ShopsController/ShopPageController.dart';
import '../controllers/orders/OrdersController.dart';
import '../controllers/products/ProductController.dart';

class Initial_Binding extends  Bindings{
  @override
  void dependencies() {
    Get.put<ShopPageController>(ShopPageController()) ;
    Get.put<ProductController>(ProductController()) ;
    Get.put<OrdersController>(OrdersController()) ;

  }

}