import 'dart:developer';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:pusher_client/pusher_client.dart';

import '../../../main.dart';
import '../../../view/notificationApi.dart';
import '../products/ProductController.dart';

class SingltoneNotification  extends GetxController{

  static final SingltoneNotification _SingltonePusher =
  SingltoneNotification._internal();

  factory SingltoneNotification() {
    return _SingltonePusher;
  }
  var sender_id=''.obs;
  SingltoneNotification._internal();
  PusherClient? pusher;
  Channel? channel;



  initPusher() {
    PusherOptions options = PusherOptions(
      cluster: "us2",
    );

    pusher = PusherClient("1ecb9f6c6b79e2404d36", options,
      enableLogging: true, autoConnect: false,
    );
  }

  void subscribePusher(sender) {
    final controller = Get.put(ProductController());

    print("=====sender=======");
    print(sender_id);
    print(sender);

    print("=====sender=======");
    channel = pusher!.subscribe("public-channel.${sender_id}");
    pusher!.onConnectionStateChange((state) {
      log("previousState: ${state!.previousState}, currentState: ${state.currentState}");
    });
    pusher!.onConnectionError((error) {
      log("error: ${error!.message}");
    });
    channel!.bind("NotificationEvent", (last) {

      final data = json.decode(last!.data.toString());
      if(data["message"]!='chat' && data["title"]!='title')
        NotificationApi.showNotification(id:1 ,payload:"sdsgdg" ,body:data['message'],title:data['title'] );
      else {
        controller.i.value++;
      }
      if (last.data != null) {

        print(data["message"]);
        print(data["title"]);
        print(controller.i.value);



      }
    });


  }

  void connectPusher() {
    pusher!.connect();
  }

  void disconnectPusher() async {
    await channel!.unbind("NotificationEvent");
    await pusher!.disconnect();
  }


  inti() async {


    sender_id.value=(await storage.read(key: 'id'))!;

    print(sender_id.value);
    SingltoneNotification().initPusher();
    SingltoneNotification().connectPusher();
    SingltoneNotification().subscribePusher(sender_id.value);
  }

  @override
  void onInit() {


  }



}






