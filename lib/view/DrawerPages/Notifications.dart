import 'package:customers/logic/controllers/Notification/NotificationController.dart';
import 'package:customers/view/Mazad.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controllers/DrawerController/SettingPageController.dart';
import '../../main.dart';
import '../../utls/Themes.dart';
import '../ConstantPages/RoundedAppBar.dart';

class NotificationPage extends GetView<SettingPageController> {
  @override
  Widget build(BuildContext context) {
    NotificationController controller = Get.put(NotificationController());
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: RoundedAppBar(),
            backgroundColor: Themes.color2,
            body: RefreshIndicator(onRefresh: () {
              return Future.delayed(
                Duration(seconds: 1),
                () {
                  controller.fetch_notification();
                },
              );
            }, child: Obx(() {
              if (controller.isLoading.value) {
                return ListView.builder(
                    itemCount: controller.notifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, bottom: 15),
                        child: InkWell(
                          onTap: () {
                            if(controller.notifications.elementAt(index).title == 'مزاد')
                              {
                                int raise_id = int.parse(controller.notifications.elementAt(index).message) ;
                                Get.to(Mazad(raise_id)) ;
                              }
                          },
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              selected: true,
                              contentPadding: EdgeInsets.all(20),
                              selectedTileColor: Colors.white,
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '${MyApp.api}/uploads/stores/${controller.notifications.elementAt(index).store_image}'),
                                radius: 35,
                              ),
                              trailing: Text(
                                "${controller.notifications.elementAt(index).created_at} ",
                                style: Themes.subtitle3,
                              ),
                              title: Text(
                                "${controller.notifications.elementAt(index).title}",
                                style: Themes.subtitle1,
                              ),
                              subtitle: Text(
                                "${controller.notifications.elementAt(index).message}",
                                style: Themes.subtitle2,
                              )),
                        ),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }))));
  }
}
