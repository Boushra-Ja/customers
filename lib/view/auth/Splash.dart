import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../logic/controllers/auth/SplashController.dart';
import '../../utls/Themes.dart';

class RouteAuth extends GetView<SplashController> {
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: MediaQuery.of(context).size.height / 6,
        child: Scaffold(
            body: Column(children: [
          Expanded(child: Obx(
            () {
              return controller.loading.value
                  ? Center(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: new AssetImage("images/4.jpg"))),
                      ),
                    )
                  : loading_page();
            },
          )),
        ])));
  }
}

class loading_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.grey.shade100,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Center(
          child: SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Themes.color : Themes.color2,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
