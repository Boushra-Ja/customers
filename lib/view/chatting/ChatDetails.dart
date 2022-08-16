import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controllers/Chats/ChatDetailsController.dart';
import '../../logic/controllers/Notification/SingltonePusher.dart';
import '../../main.dart';
import '../../services/auth_services.dart';
import '../../utls/Themes.dart';


class ChatDetails extends GetView<ChatDetailsController> {

  // final controller = Get.put(ChatDetailsController());

  final messageInsert = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatDetailsController());
    final controller2 = Get.put(SingltonePusher());


    return Directionality(
        textDirection: TextDirection.rtl,
        child:Scaffold(
            body:
            Obx(()
            {    return
              Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,),
                    Card(
                      child: ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            controller2.disconnectPusher();
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                        //  backgroundImage: AssetImage("${controller.Images
                          //     .value}"),
                        ),
                        title: Text(controller.name.value,
                          style: Themes.bodyText1,
                        ),
                        subtitle: Text(
                          "  .....  ",
                          style: Themes.subtitle2,
                        ),
                      ),
                    ),

                    Flexible(
                        child: ListView.builder(
                            reverse: true,
                            itemCount: controller.messsages.length,
                            itemBuilder: (context, index) =>
                                controller.chat(
                                    controller.messsages[index]["message"].toString(),
                                    controller.messsages[index]["data"]))),

                    Divider(
                      height: 5.0,
                      color: Colors.grey.shade600,
                      thickness: 1,
                    ),

                    Container(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.grey.shade600,
                            size: 35,
                          ),
                          onPressed: () {},
                        ),
                        title: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 15),
                          child: TextFormField(
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            controller: messageInsert,
                            decoration: InputDecoration(
                              hintText: "  ادخل رسالتك... ",
                              hintStyle: Themes.subtitle3,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            style: Themes.bodyText1,
                            onChanged: (value) {},
                          ),
                        ),
                        trailing: IconButton(
                            icon: Icon(
                              Icons.send,
                              size: 30.0,
                              color: Colors.grey.shade600,
                            ),
                            onPressed: () async {

                              print("-----------------------------------------------------");
                              print(controller.receiver_id);
                              int r=int.parse(controller.receiver_id.value);
                              print("-----------------------------------------------------");
                              if (messageInsert.text.isEmpty) {
                                print("empty message");
                              } else {
                                controller.messsages.insert(
                                    0  , {
                                  "data": 0,
                                  "message": messageInsert.text
                                });
                                var mess=messageInsert.text;
                                messageInsert.text='';
                                await AuthServices.send(
                                    message: mess,
                                    sender_id : (await storage.read(key: 'id'))!,
                                    receiver_id: controller.receiver_id.value);






                              }
                              FocusScopeNode currentFocus = FocusScope.of(
                                  context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            }),
                      ),
                    ),


            ]);
            })
        )
    );
  }


}