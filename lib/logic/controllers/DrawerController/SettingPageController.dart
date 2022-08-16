
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class SettingPageController extends GetxController{

 // static SettingPageController get to => Get.find();
  var boolean;
  final _box = GetStorage();

  var col = 0.obs ;
  final storage = const FlutterSecureStorage();
  var user_name  , image;


  ThemeMode j =ThemeMode.light;
   var _themeMode = ThemeMode.light.obs ;

  ThemeMode get themeMode => _themeMode.value;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    Get.changeThemeMode(themeMode);
  _themeMode.value = themeMode ;
  print("0==========================================0");
  print(_themeMode.value);
  print("0==========================================0");
    update();

  }

 void setTheme(int inh)  {

    col.value=inh;
    print("0==========================================0");
    print(col);
    print("0==========================================0");
    update();

  }

  get()async{
     var c =await storage.read(key: "isDarkMode") ;
     if(c=="false")
       {
         col.value=0;

       }
     else {
       col.value=1;

     }

  }
  @override
  void onInit()async {

    get();
    user_name = await storage.read(key: 'name');

    super.onInit();
  }

  // getThemeModeFromPreferences() async {
  //   ThemeMode themeMode;
  //   prefs = await SharedPreferences.getInstance();
  //   String themeText = prefs.getString('theme') ?? 'light';
  //   try {
  //     themeMode =
  //         ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
  //   } catch (e) {
  //     themeMode = ThemeMode.system;
  //   }
  //   setThemeMode(themeMode);
  // }


  var selectedLanguage = 'العربية';
  var langList = [
    'العربية' ,
    'الانجليزية'
  ] ;
  bool chexboxlight = true ;
  bool chexboxdark = false ;

  void setselectedLanguage (String val)
  {
    selectedLanguage = val ;
    update() ;
  }

  void setselectedcheckboxlight (var val)
  {
    chexboxlight = val ;
    update() ;
  }
  void setselectedcheckboxdark (var val)
  {
    chexboxdark = val ;
    update() ;
  }

}