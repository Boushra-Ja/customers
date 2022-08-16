import 'dart:developer';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:pusher_client/pusher_client.dart';

import '../../../main.dart';
import '../../../view/notificationApi.dart';
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

int i=0;

  initPusher() {
    PusherOptions options = PusherOptions(
      cluster: "us2",
    );

    pusher = PusherClient("1ecb9f6c6b79e2404d36", options,
      enableLogging: true, autoConnect: false,
    );
  }

  void subscribePusher(sender_id) {

    print(sender_id);
    print("=====sender=======");
    print(sender_id);
    print("=====sender=======");
    channel = pusher!.subscribe("public-channel.${sender_id}");
    pusher!.onConnectionStateChange((state) {
    //  log("previousState: ${state!.previousState}, currentState: ${state.currentState}");
    });
    pusher!.onConnectionError((error) {
    //  log("error: ${error!.message}");
    });
    channel!.bind("NotificationEvent", (last) {

      final data = json.decode(last!.data.toString());
      NotificationApi.showNotification( id:i++  ,
          body:data['message'],
          title:data["title"] ,);
      if (last.data != null) {

        print(data);

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
    inti();


  }



}






