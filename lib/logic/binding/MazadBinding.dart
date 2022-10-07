import 'package:get/get.dart';
import '../controllers/Notification/MazadController.dart';


class MazadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MazadController());
  }}