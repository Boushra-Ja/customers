import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import 'SingltoneMazad.dart';

class MazadController extends GetxController {
  var name=''.obs;
  MazadController();
  final controller = Get.put(SingltoneMazad());
  var count= 0.obs;
  var counter= 30.obs;
  late Timer _timer;
  final messageInsert = TextEditingController();
  List<Map> messsages = [];
  d()async{
    name.value=   (await storage.read(key: 'name'))! ;
    // print("===============================================");
    // print(name.value);
    // print("===============================================");
  }
  void starttime(){

    controller.initPusher();
    controller.connectPusher();
    controller.subscribePusher();
    _timer=Timer.periodic(Duration(seconds: 1), (timer) {
      if(counter>0){
        counter--;
        update();


      }
      else
      {

        _timer.cancel();
        update();
      }



    });


  }

  @override
  void onInit() {
    // messsages[0]['number']=0;


    d();

    starttime();
  }

  void dispose() {
    controller.disconnectPusher();

  }}