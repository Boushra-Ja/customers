
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../logic/controllers/DrawerController/SettingPageController.dart';
import '../../utls/Themes.dart';

class RoundedAppBar extends GetView<SettingPageController> implements PreferredSizeWidget {

  final sampleController3 = Get.put(SettingPageController(), permanent: true);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        new SizedBox.fromSize(
          size: preferredSize,
          child: new LayoutBuilder(builder: (context, constraint) {
            final width = constraint.maxWidth * 9;
            return new ClipRect(
              child: new OverflowBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: new SizedBox(
                  width: width,
                  height: width - 40,
                  child: new Padding(
                    padding: new EdgeInsets.only(
                        bottom: width / 2 - preferredSize.height / 2),
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        color: sampleController3.col==0?
                      Themes.color:Colors.grey,
                        shape: BoxShape.circle,
                        boxShadow: [
                          new BoxShadow(color: Colors.black54, blurRadius: 10.0)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 20),
            child: Align(
                child: CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color:
                    Themes.color,
                  ),
                  backgroundColor: Colors.grey.shade200,
                ),
                alignment: Alignment.topRight),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}


