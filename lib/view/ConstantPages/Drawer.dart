import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../logic/controllers/DrawerController/SettingPageController.dart';
import '../../logic/controllers/products/ProductController.dart';
import '../../utls/Themes.dart';
import '../DrawerPages/GiftRequest.dart';
import '../DrawerPages/Notifications.dart';
import '../DrawerPages/ReportPage.dart';
import '../DrawerPages/SettingPage.dart';
import '../DrawerPages/ShowDiscounts.dart';
import '../auth/LoginView.dart';

class myDrawer extends GetView<SettingPageController> {
  final controllerp = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    var storage = const FlutterSecureStorage();


    return GetX<SettingPageController>(
      builder: (c) =>  Drawer(
        backgroundColor:  controller.col==1?
        Colors.black
            :Colors.white,

        child: GetX<SettingPageController>(
          builder: (c) =>  ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color:
                  controller.col==1?Colors.grey:Themes.color2,



                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/shop.png'),
                      radius: 50,
                    ),
                    Text("${controller.user_name}", style: Themes.bodyText2,)
                  ],
                ),
              ),
              SizedBox(height: 25,),
              ListTile(
                leading: Icon(Icons.card_giftcard),
                title:  Text('طلب هدية', style: Themes.subtitle2

                  // Themes.bodyText1,
                ),
                onTap: () {
                  Get.to(()=>GiftRequest()) ;
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications_active),
                title:  Text('الإشعارات', style:
                Themes.subtitle2

                  //  Themes.bodyText1,
                ),
                onTap: () {
                  Get.to(NotificationPage()) ;

                },
              ),
              ListTile(
                leading: Icon(Icons.chat),
                title:  Row(
                  children: [

                    Text('المحادثات', style: Themes.subtitle2),
                    SizedBox(width: 30,),
                    CircleAvatar(child: Text("${controllerp.i.value}",style: TextStyle(color: Colors.black),),backgroundColor: Themes.color2,)

                  ],


                ),
                onTap: () {
                  Get.toNamed('/chatting');
                  controllerp.i.value=0;

                },
              ),
              ListTile(
                leading: Icon(Icons.chat),
                title:  Text('خصوماتي', style: Themes.subtitle2
                  // Themes.bodyText1,
                ),
                onTap: () {
                  Get.to(ShowDiscounts()) ;

                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title:  Text('الإعدادات', style:Themes.subtitle2
                  //  Themes.bodyText1,
                ),
                onTap: () {
                  Get.to(SettingPage()) ;

                },
              ),
              ListTile(
                leading: Icon(Icons.report),
                title:  Text('إبلاغ', style: Themes.subtitle2
                  //Themes.bodyText1,
                ),
                onTap: () {
                  Get.to(ReportPage()) ;

                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title:  Text('تسجيل الخروج', style:Themes.subtitle2
                  //  Themes.bodyText1,
                ),
                onTap: ()async {
                  await(storage.deleteAll());
                  Get.off(LoginView()) ;
                  },
              ),
            ],
          ),),),

    );


  }

}