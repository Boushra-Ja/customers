import 'dart:developer';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:pusher_client/pusher_client.dart';

import '../../../main.dart';
import '../Chats/ChatDetailsController.dart';

class SingltonePusher  {

  static final SingltonePusher _SingltonePusher =
  SingltonePusher._internal();

  factory SingltonePusher() {
    return _SingltonePusher;
  }
  var sender_id=''.obs;
  SingltonePusher._internal();
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

  void subscribePusher(receiver_id) {
    final controller = Get.put(ChatDetailsController());
    // controller.i.value=controller.i.value+1;
    print("=====sender=======rceiver=========");
    print(sender_id.value);
    print(receiver_id);
    print("=====sender=======rceiver=========");
    channel = pusher!.subscribe("public-channel.${sender_id.value}.${receiver_id}");
    pusher!.onConnectionStateChange((state) {
      log("previousState: ${state!.previousState}, currentState: ${state.currentState}");
    });
    pusher!.onConnectionError((error) {
      log("error: ${error!.message}");
    });
    channel!.bind("ChatEvent", (last) {

      final data = json.decode(last!.data.toString());
      print(data);
      if (last.data != null) {

        controller.i.value=controller.i.value+1;

        print("00000088880000000000");
        print(data['message']);
        print(controller.i.value);
        print("0000000888000000000");

        controller.messsages.insert(
            0 , {
          "data": 1,
          "message": data['message']
        });

        controller.chat(
            data['message'],
            1);


      }
    });


  }

  void connectPusher() {
    pusher!.connect();
  }

  void disconnectPusher() async {
    await channel!.unbind("ChatEvent");
    await pusher!.disconnect();
  }


  inti(receiver_id) async {
    sender_id.value=(await storage.read(key: 'id'))!;

    print("one...");
    print(receiver_id);
    print(sender_id.value);
    print("one...");

    SingltonePusher().initPusher();
    SingltonePusher().connectPusher();
    SingltonePusher().subscribePusher(receiver_id);
    // SingltonePusher().disconnectPusher();
  }

  @override
  void onInit() {


  }



}






