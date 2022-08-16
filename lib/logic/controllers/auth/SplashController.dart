import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../../routes/routes.dart';

class SplashController extends GetxController {

  var loading = true.obs;
  final storage=const FlutterSecureStorage();
  Future<void> isAuth() async {
    var storage = const FlutterSecureStorage();
    var token = ''.obs;
    late var result = ''.obs;

    try {
     token.value=(await storage.read(key: 'token'))!;
      print(token);
      result.value = 'OK';
    } catch (e) {
      result.value = 'NOOK';
    }
    Timer(
        Duration(seconds: 3),
            () =>
            Get.offAllNamed(
              token.value.isEmpty
                  ? Routes.WelcomPage
                  : Routes.HomePage,
            )
    );

  }
  Future clerestorage()async{
    await(storage.deleteAll());
    var iys=await( storage.read(key: 'token'));
  }

  @override
  void onInit() {
     //clerestorage();
    splash();
    super.onInit();
  }

  splash() async {
    await storage.write(key: 'basket', value: null);

    try {
      loading.value = true;
      await isAuth();
    }
    finally {
      loading.value = false;
    }
    update();
  }
}
