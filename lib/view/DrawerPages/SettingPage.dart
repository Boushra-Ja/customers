import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../../logic/controllers/DrawerController/SettingPageController.dart';
import '../../main.dart';
import '../../utls/Themes.dart';
import '../ConstantPages/MyCustomCLipper.dart';
import 'EditProfile.dart';
import 'Info_App.dart';
final box =  GetStorage();


class SettingPage extends GetView<SettingPageController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(

          // backgroundColor:
          // controller.boolean==1?
          // Colors.black:Colors.white,
          // appBar: RoundedAppBar(),
          body:
        GetX<SettingPageController>(
        builder: (c) =>  ListView(
            children: [

              ClipPath(
                child: Container(

                  color:
                  controller.col==1?Colors.black:Themes.color,
                  height: MediaQuery.of(context).size.height * 0.12,
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
                height: 25,
              ),
      GetX<SettingPageController>(
        builder: (c) =>  Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: controller.col==1?Colors.black:Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    ListTile(
                      title: Text(
                        "تعديل المعلومات الشخصية",

                        style: TextStyle( color: controller.col==1?Colors.white:Colors.black,
                        )
                        //Themes.bodyText1,
                      ),
                      trailing: IconButton(icon: Icon(Icons.edit),onPressed: (){
                        Get.to(EditProfile()) ;
                      },),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Divider(color: controller.col==1?Colors.white:Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      title: Text(
                        "معلومات عن التطبيق",
                        style: TextStyle( color: controller.col==1?Colors.white:Colors.black,
                      )
                        //Themes.bodyText1,
                      ),
                      trailing: IconButton(icon: Icon(Icons.details),onPressed: (){
                        Get.to(InfoApp());
                       },),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Divider(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListTile(
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "لغة التطبيق",
                              style:TextStyle( color: controller.col==1?Colors.white:Colors.black,
                        )
                              //Themes.bodyText1,
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            GetBuilder<SettingPageController>(
                              init: SettingPageController(),
                              builder: (controller) {
                                return Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: 35,
                                  child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(30)),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10, 0.001, 12, 0.001),
                                          filled: true,
                                          fillColor: Colors.white),
                                      hint: Text(
                                        "العربية",
                                        style:  TextStyle( color: controller.col==1?Colors.white:Colors.black,
                                      )
                                        //Themes.subtitle2,
                                      ),
                                      value: controller.selectedLanguage,
                                      alignment: Alignment.center,
                                      style: Themes.subtitle2,
                                      onChanged: (newValue) {
                                        controller.setselectedLanguage(
                                            newValue.toString());
                                      },
                                      items: [
                                        for (var data in controller.langList)
                                          DropdownMenuItem(
                                            child: Text(
                                              "${data}",
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.start,
                                              style:  TextStyle(
                                                fontWeight: FontWeight.w300,
                                                   color:
                                                   Colors.black,

                                              ),
                                            ),
                                            value: "${data}",
                                          )
                                      ]),
                                );
                              },
                            )
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Divider( color: controller.col==1?Colors.white:Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListTile(
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "ألوان التطبيق",
                              style: TextStyle( color: controller.col==1?Colors.white:Colors.black,
                        )
                              //Themes.bodyText1,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    GetBuilder<SettingPageController>(
                                      init: SettingPageController(),
                                      builder: (controller) {
                                        return Checkbox(
                                          value: controller.chexboxlight,

                                          activeColor:
                                          controller.col==1?Colors.white:Colors.black,

                                          //Themes.color,
                                          onChanged: (value) async{
                                            controller.setTheme(0);
                                          //   Get.changeThemeMode(ThemeMode.light);
                                          //
                                          await  box.write("isDarkMode", false);
                                             await  storage.write(key:"isDarkMode", value: 'false');
                                          //
                                             //  controller.setThemeMode(ThemeMode.light);

                                            controller
                                                .setselectedcheckboxlight(value);
                                            controller
                                                .setselectedcheckboxdark(false);
                                          },
                                        );
                                      },
                                    ),
                                    Text("نهاري",style: TextStyle( color: controller.col==1?Colors.white:Colors.black,
                                    ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    GetBuilder<SettingPageController>(
                                      init: SettingPageController(),
                                      builder: (controller) {
                                        return Checkbox(
                                          activeColor: Themes.color,
                                          value: controller.chexboxdark,
                                          onChanged: (value) async {
                                            //
                                             await  box.write("isDarkMode", true);
                                             await  storage.write(key:"isDarkMode", value: 'true');
                                            controller.setTheme(1);

                                          //  controller.setThemeMode(ThemeMode.dark);
                                          //   Get.changeThemeMode(ThemeMode.dark);
                                            controller
                                                .setselectedcheckboxdark(value);
                                            controller
                                                .setselectedcheckboxlight(false);
                                          },
                                        );
                                      },
                                    ),
                                    Text("ليلي",style: TextStyle( color: controller.col==1?Colors.white:Colors.black,
                                    ))
                                  ],
                                )
                              ],
                            )
                          ],
                        )),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/setting.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "الإصدار 1.0.0.0",
                  style:TextStyle( color: controller.col==1?Colors.white:Colors.black,
                )
                  //Themes.subtitle2,
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),),
        ));
  }
}