import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../../../main.dart';
import 'package:path/path.dart';

class EditProfileController extends GetxController{
  late TextEditingController name_controller ;
  late TextEditingController email_controller ;
  late TextEditingController phone_controller ;

  var isLoading = true.obs , isEdit = true.obs  ;
  var user_name  , email  , image , user_id , password , new_pass , token;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate2 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate3 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate4 = new GlobalKey<FormState>();
  final storage=const FlutterSecureStorage();
  var imagepicker = ImagePicker(), photo;
  late File file;
  var check_pass = true.obs ;

  @override
  void onInit()async{
    name_controller = TextEditingController () ;
    email_controller = TextEditingController () ;
    phone_controller = TextEditingController() ;
    super.onInit();
    await fetch_info() ;

  }

  void set_chechpass(var val ){
    check_pass.value = val ;
    update() ;
  }

  Future<void> fetch_info()async{

    user_id  = await storage.read(key: 'id') ;
    user_name = await storage.read(key: 'name') ;
    email = await storage.read(key: 'email') ;
    image =  await storage.read(key: 'image') ;
    password =  await storage.read(key: 'password') ;
    token =  await storage.read(key: 'token') ;

    isLoading.value = false ;
    update() ;

  }

  @override
  void dispose() {
    name_controller.dispose();
    email_controller.dispose();
    phone_controller.dispose();
    super.dispose();
  }

  void set_username(var val ) {
    user_name = val ;
    update() ;
  }

  String? validate_username(var val ) {
    if(val == '')
    {
      return "الرجاء إدخال الاسم";
    }
    return null ;
  }

  void set_email(var val ) {
    email = val ;
    update() ;
  }

  String? validate_email(var value) {
    if (!GetUtils.isEmail(value))
      return "الايميل غير صالح";
     else
      return null;

  }

  String? validateNewPassword(var value) {
    if(value.length == 0)
      return "الحقل مطلوب"  ;

    if (value.length <= 5)
      return "كلمة المرور قصيرة";

    return null;
  }

  String? validateOldPassword(var value) {
    if (value != password)
      return "كلمة المرور غير صحيحة";

    return null;
  }

  void set_newpassword(var val ) {
    new_pass = val ;
    update() ;
  }

  Future<void> editProfile()async{
    var formdata = formstate.currentState;
    var formdata2 = formstate2.currentState;
    var formdata3 = formstate3.currentState;
    var formdata4 = formstate4.currentState;

    isEdit.value = false ;
    if (formdata!.validate() && formdata2!.validate() ) {

      formdata.save();
      formdata2.save();

      if(check_pass.value==false && formdata3!.validate() && formdata4!.validate())
      {
        formdata3.save() ;
        formdata4.save() ;
      }

      if( check_pass.value || (check_pass.value==false && formdata3!.validate() && formdata4!.validate()))
      {
        final response = await http.post(
          ////user id
            Uri.parse('${MyApp.api}/api/edit_profile/${user_id}'),
            headers: {'Content-Type': 'application/json',
              'Accept': 'application/json', 'Authorization': 'Bearer $token'},
            body: jsonEncode(<String, dynamic>{
              "name": user_name,
              "email": email,
              "image": image
            }));
        await storage.write(key: "id", value: '${user_id}');
        await storage.write(key: "name", value:'${user_name}');
        await storage.write(key: "email", value: '${email}');
        await storage.write(key: "image", value: '${image}');

        if(check_pass.value ==false)
          {
            await storage.write(key: "password", value: new_pass) ;
            await changePassword();
          }
        Get.back() ;
      }

      isEdit.value = true ;
      update() ;

    }

  }

  UploadImages(int num ) async {
    var picker ;
    if (num == 1)
      picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    else
      picker = await ImagePicker().pickImage(source: ImageSource.camera);

    if (picker != null) {
      file = File(picker.path);
      var nameImage = basename(picker.path);
      var random = Random().nextInt(10000);
      nameImage = "$random$nameImage";
      photo = file;
      print(photo) ;

    }
  }

  Future<void> changePassword()async{

    final response = await http.post(
        Uri.parse('${MyApp.api}/api/Customer/changepassword'),
        headers: {'Content-Type': 'application/json',
          'Accept': 'application/json', 'Authorization': 'Bearer $token'},
        body: jsonEncode(<String, dynamic>{
          "old_password": password,
          "password": new_pass,
        }));
    if(response.statusCode == 200)
      {
        print('change password') ;
      }
  }

}