import 'package:get/get.dart';

import '../controllers/auth/RegesterController.dart';



class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }}