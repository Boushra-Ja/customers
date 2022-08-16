import 'package:get/get.dart';

import '../controllers/Chats/ChatController.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ChatController());


  }}