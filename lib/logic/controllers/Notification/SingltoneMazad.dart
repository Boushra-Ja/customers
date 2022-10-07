import 'dart:developer';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:pusher_client/pusher_client.dart';

import 'MazadController.dart';

class SingltoneMazad  {

  static final SingltoneMazad _SingltoneMazad =
  SingltoneMazad._internal();
  static final controller2 = Get.put(MazadController());

  factory SingltoneMazad() {

    return _SingltoneMazad;
  }
  SingltoneMazad._internal();
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

  void subscribePusher() {


    channel = pusher!.subscribe("public-channelMazad");
    pusher!.onConnectionStateChange((state) {
      // log("previousState: ${state!.previousState}, currentState: ${state.currentState}");
    });
    pusher!.onConnectionError((error) {
      // log("error: ${error!.message}");
    });
    channel!.bind("MazadEvent", (last) {

      final data = json.decode(last!.data.toString());
      print(data);
      if (last.data != null) {


        //  print("00000088880000000000");
        // //  print(int.parse(data['number'])+controller2.count.value);
        //   print(data['name']);
        //   print(controller2.name.value);
        //  print("0000000888000000000");


        if(data['name']!=controller2.name.value)
        {
          print("insert");
          controller2.messsages.insert(1, {
            "data": 1,
            "name": data['name'],
            "number": int.parse(data['number'])+controller2.count.value});

          controller2.count.value=int.parse(data['number'])+controller2.count.value;
          if(controller2.counter.value!=0)
          {  print("value");
          controller2.counter.value=60;

          }

        }




      }
    });


  }

  void connectPusher() {
    pusher!.connect();
  }

  void disconnectPusher() async {
    await channel!.unbind("MazadEvent");
    await pusher!.disconnect();
  }


  inti() async {


    SingltoneMazad().initPusher();
    SingltoneMazad().connectPusher();
    SingltoneMazad().subscribePusher();
    // SingltoneMazad().disconnectPusher();
  }

  @override
  void onInit() {


  }



}






