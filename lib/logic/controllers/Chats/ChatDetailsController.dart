
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:pusher_client/pusher_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../main.dart';
import '../../../models/batool/ChatDetailsModel.dart';
import '../Notification/SingltonePusher.dart';

class ChatDetailsController extends GetxController {
  ChatDetailsController();

  final controller = Get.put(SingltonePusher());

  var sender_id=''.obs;
  int i=1;
  var listmessage = <ChatDetails>[].obs ;
  late List<dynamic> jsonResponse;
  var chat_id=''.obs;
  var name=''.obs;
  var receiver_id=''.obs;
  String? _message;
  // get message => _message;
  ChatDetailsController._internal();
  var messsages = [].obs ;




  Widget chat(String message, int data) {

    print(message);
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
        data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // data == 0
          //     ? Container(
          //       height: 50,
          //       width: 60,
          //       child: CircleAvatar(
          //         radius: 10,
          //     //  backgroundImage: AssetImage("${controller.Images.value}" ),
          //   ),
          // )
          //     : Container(),
          //



          Padding(

            padding: EdgeInsets.all(10.0),
            child: Bubble(
               // radius: Radius.circular(80.0),
                color: data == 0 ? Colors.purple.shade200 : Colors.teal.shade200,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 200),
                            child: Text(
                              message,
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                )
            ),
          ),


          //
          // data == 1
          //     ? Container(
          //   height: 50,
          //   width: 60,
          //   child: CircleAvatar(
          //     radius: 5,
          //     backgroundImage: AssetImage("images/3.jpg"),
          //   ),
          // )
          //     : Container(),
        ],
      ),
    );
  }

  inti() async {
    sender_id.value=(await storage.read(key: 'id'))!;

  }

  @override
  void onInit() {

    chat_id.value=Get.arguments['chat_id'];
    name.value=Get.arguments['name'];
    receiver_id.value=  Get.arguments['receiver_id'];
    print( receiver_id.value);
    print( chat_id.value);
    //
    ChatDetail(chat_id.value);

    controller.inti(receiver_id.value);

  }

  ChatDetail(chat_id) async {
    var result;
    print(chat_id);
    final response = await http.get(
      Uri.parse('${MyApp.api}/api/message/index/${chat_id}/1'),
    );

    print(response.body);
    if (response.statusCode == 200)
    {
      jsonResponse = json.decode(response.body);
      result= jsonResponse
          .map((data) => new ChatDetails.fromJson(data))
          .toList();
    }
    else
      result= null;

   // ChatDetailsModel productModel = ChatDetailsModel.fromJson(jsonDecode(response.body));
    listmessage.assignAll(result);
    update();

    for(int i=0;i<listmessage.length;i++)
    {

      if(listmessage.elementAt(i).sender_id.toString()==await storage.read(key: 'id'))
        messsages.insert(
            0  , {
          "data": 0,
          "message": listmessage.elementAt(i).message
        });
      else
        messsages.insert(
            0  , {
          "data": 1,
          "message": listmessage.elementAt(i).message
        });


    }
    update();
  }

}






