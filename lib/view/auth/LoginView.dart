import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../logic/controllers/auth/LoginController.dart';
import '../../utls/Themes.dart';


class LoginView extends GetView<LoginController> {

  LoginController controller = Get.put(LoginController()) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('images/login.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.25,
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Themes.color2,
                                elevation: 10,
                                child: Form(
                                  key: controller.loginFormkey,
                                  child: Column(children: <Widget>[
                                    SizedBox(
                                      height: 40,
                                    ),

                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 15),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "البريد الالكتروني  ",
                                              style: Themes.bodyText1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 5),
                                      height: 50,
                                      child: TextFormField(
                                        controller: controller.emailController,
                                        validator: (v) {
                                          controller.validateEmail(v!);
                                          if (v.isEmpty)
                                            return 'ادخل ايميلا صحيحا';
                                          else if (v.length > 100)
                                            return "لا يمكن ان يكون بهذا الحجم";
                                          else if (v.length < 2)
                                            return "لا يمكن ان يكون اقل من حرفين";
                                          return null;

                                        },
                                        onSaved: (v) {controller.email=v!;
                                        },
                                        style: TextStyle(
                                          //: 40.0,
                                          height: 1.0,
                                        ),
                                        autocorrect: true,
                                        decoration: InputDecoration(
                                          hintText:
                                              ' ادخل بريدك الالكتروني....',
                                          hintStyle: Themes.subtitle3,
                                          filled: true,
                                          fillColor: Colors.white70,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0)),
                                            borderSide: BorderSide(
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 15),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text("كلمه المرور  ",
                                                style: Themes.bodyText1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 5),
                                      height: 50,
                                      child: TextFormField(
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            controller: controller.passwordController,
                                            validator: (v) {
                                            controller.validatePassword(v!);
                                            if (v.isEmpty)
                                            return 'ادخل كلمة مرور صحيحا';
                                            else if (v.length > 100)
                                            return "لا يمكن ان يكون بهذا الحجم";
                                            else if (v.length < 2)
                                            return "لا يمكن ان تكون اقل من حرفين";
                                            return null;
                                            },
                                            onSaved: (v) {controller.password=v!;},
                                        style: TextStyle(
                                          //: 40.0,
                                          height: 1.0,
                                        ),
                                        autocorrect: true,
                                        decoration: InputDecoration(
                                          hintText: ' ادخل كلمه المرور....',
                                          hintStyle: Themes.subtitle3,
                                          filled: true,
                                          fillColor: Colors.white70,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0)),
                                            borderSide: BorderSide(
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),

                                    Obx(()=>
                                    controller.isLoading.value == true ?
                                    const  Center(child:
                                    CircularProgressIndicator ()): const Text("")),
                                    MaterialButton(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      onPressed: () {
                                        controller.doLogin();
                                      },
                                      color: Themes.color,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        "تسجيل الدخول",
                                        style: Themes.button_text,
                                      ),
                                    ),
                                    // InkWell(onTap:(){Get.toNamed('/HomePage'); },child: CircleAvatar(
                                    //     backgroundColor: Themes.color,
                                    //     radius: 40,
                                    //     child: Text(
                                    //       " تسجيل الدخول ",
                                    //       style:
                                    //       TextStyle(fontSize: 12, color: Colors.white),
                                    //     ), //Text
                                    //   ),), //CircleAvatar
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Center(
                                    child: MaterialButton(
                                      onPressed: () {
                                        Get.offNamed('/regester');
                                      },
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "  انشاء حساب  ",
                                        style: Themes.no_select_text,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Center(
                                    child: MaterialButton(
                                      onPressed: () {},
                                      color: Colors.purple[50],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        " تسجيل دخول ",
                                        style: Themes.select_option_text,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              )
            ])));
  }
}
