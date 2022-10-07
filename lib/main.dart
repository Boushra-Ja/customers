import 'package:customers/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'logic/binding/Initial_Binding.dart';
import 'logic/controllers/DrawerController/SettingPageController.dart';

final storage =const FlutterSecureStorage();
final sampleController3 = Get.put(SettingPageController(), permanent: true);
String? isDarkMode;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  isDarkMode =await  storage.read(key: "isDarkMode")  ;
  await GetStorage.init();
  await GetStorage.init();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  static String api = "http://192.168.43.188:8000" ;

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.Splash,
      getPages: AppPages.routes,
      initialBinding: Initial_Binding(),
    );
  }
}
