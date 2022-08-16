import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarController extends GetxController{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey3 = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey4 = GlobalKey<ScaffoldState>();

  late PageController pageController;
  var currentIndex = 3.obs ;
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  void onInit() {
    super.onInit();
  pageController = PageController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
  }

  GlobalKey<ScaffoldState> getscaffoldKey2 (){
    return _scaffoldKey2 ;
  }

  GlobalKey<ScaffoldState> getscaffoldKey (){
    return _scaffoldKey ;
  }
  GlobalKey<ScaffoldState> getscaffoldKey3 (){
    return _scaffoldKey3 ;
  }
  GlobalKey<ScaffoldState> getscaffoldKey4 (){
    return _scaffoldKey4 ;
  }

}