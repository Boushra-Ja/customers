import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controllers/Chats/ChatController.dart';
import '../../logic/controllers/DrawerController/SettingPageController.dart';
import '../../main.dart';
import '../../utls/Themes.dart';
import '../ConstantPages/MyCustomCLipper.dart';

class Chat extends GetView<ChatController> {

 final h= Get.lazyPut(()=>ChatController());
  Color? colorh = Themes.color;
  Color colorh8 = Colors.grey.shade300;

  @override
  Widget build(BuildContext context) {
    return Directionality(
         textDirection: TextDirection.rtl,
         child:GetBuilder<ChatController>(
          init: ChatController(),
           builder: (_controller) {
           return Scaffold(
              body: Column(
                children: [
                  ClipPath(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Themes.color2,
                                      // backgroundImage: NetworkImage("${MyApp.api}/uploads/product/${controller.listchat.elementAt(0).image}",),
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Themes.color,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]))),
                    ),
                    clipper: MyCustomCLipper(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Form(
                      // key: ,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "ابحث...",
                          hintStyle: Themes.bodyText5,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: colorh8)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: ListView.builder(
                          itemCount: controller.listchat.length,
                          itemBuilder: (context, index) {
                         return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: TextButton(
                              onPressed: () => {

                                 print(controller.listchat.elementAt(index).receiver_id),
                                Get.toNamed('/ChatDetails', arguments: {
                                  "name": controller.listchat.elementAt(index).name,
                                   "chat_id":controller.listchat.elementAt(index).chat_id.toString(),
                                    "receiver_id":controller.listchat.elementAt(index).receiver_id.toString(),
                                //  "Image": controller.listchat.elementAt(index).image,
                                })
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                trailing: Text(
                                  "4/7/2022",
                                  style: Themes.subtitle3,
                                ),
                                leading: CircleAvatar(

                                radius: 30,
                                 backgroundImage: NetworkImage("${MyApp.api}/uploads/product/${controller.listchat.elementAt(index).image}"),
                                ),
                                title: Text(controller.listchat.elementAt(index).name, style: Themes.bodyText1),
                                subtitle: Text(
                                  "....",
                                  style: Themes.subtitle2,
                                ),
                              ),
                            ));
                      },

                    )),
                  ),
                ],
              ),
            );
          }));
                  ; // ClipPath
      }
    }
