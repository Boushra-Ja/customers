import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utls/Themes.dart';
import 'ConstantPages/MyCustomCLipper.dart';
import 'ProductsList.dart';

class SuggestionPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            //  appBar: RoundedAppBar(),
            body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              ClipPath(
                child: Container(
                  color: Themes.color,
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
              ProductsList(),
            ],
          ),
        )));
  }
}
