import 'package:get/get.dart';

import '../controllers/auth/LoginController.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut(() => LoginController());
  }}