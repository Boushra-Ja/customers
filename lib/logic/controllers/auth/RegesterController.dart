import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

import '../../../services/auth_services.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  final registerFormkey = GlobalKey<FormState>();
  late TextEditingController nameController,
      emailController,
      passwordController;
  String name = '', email = '', password = '';
  final storage = const FlutterSecureStorage();
  String temp = '';

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "الايميل غير صالح";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.length == 0) {
      return "الحقل مطلوب";
    }
    if (value.length <= 8) {
      return "كلمة السر قصيرة";
    }
      return null;

  }

  doRegister() async {
    bool isvalidate = registerFormkey.currentState!.validate();
    if (isvalidate) {
      isLoading.value = true;
      try {
        var data = await AuthServices.register(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text);

        if (data != null) {


          await storage.write(key: "token", value: data.token);
          await storage.write(key: "isDarkMode", value:"false");
          await storage.write(key: "id", value: '${data.user.id}');
          await storage.write(key: "name", value:'${ data.user.name}');
          await storage.write(key: "email", value: '${data.user.email}');
          await storage.write(key: "image", value: '${data.user.image}');
          await storage.write(key: "password", value: passwordController.text);
          registerFormkey.currentState!.save();

          Get.toNamed('/HomePage');
        }
        else {
          Get.snackbar("تسجيل دحول ", "خطا في التسجيل...اعد المحاوله!!");
        }
      } finally {
        print("__________________________________");
        var n=     await (storage.read(key: 'id'));

        print(n);
        isLoading(false);
      }
    }
  }
}
