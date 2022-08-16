import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../logic/controllers/auth/RegesterController.dart';
import '../../utls/Themes.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Directionality(
            textDirection: TextDirection.rtl,
            child:


            ListView(children: [
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
                              height: MediaQuery.of(context).size.height-200,
                              child:
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Themes.color2,
                                elevation: 10,
                                child:

                                SingleChildScrollView(
                           child:


                                  Form(
                                    key: controller.registerFormkey,
                                    child: Column(children: <Widget>[
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Text(
                                                "الاسم الثلاثي  ",
                                                style: Themes.bodyText1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        margin:
                                            EdgeInsets.only(left: 20, right: 15),
                                        child: TextFormField(
                                         // key: controller.registerFormkeyn,
                                          controller: controller.nameController,
                                          validator: (v) {
                                            if (v!.isEmpty)
                                              return 'الاسم مطلوب';
                                            else if (v.length > 30)
                                              return "لا يسمح باكثر من 30 حرف";
                                            else if (v.length < 2)
                                              return "الاسم قصير للغاية!!!";
                                            return null;                                        },
                                          onSaved: (v) {
                                            controller.name=v!;

                                            },

                                          style: TextStyle(
                                            //: 40.0,
                                            height: 1.0,
                                          ),
                                          autocorrect: true,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          decoration:  InputDecoration(
                                            hintText: ' ادخل الاسم الثلاثي....',
                                            hintStyle: Themes.subtitle3,
                                            filled: true,
                                            errorMaxLines: 10,
                                            fillColor: Colors.white70,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.black, width: 1),
                                            )
                                            ,
                                            errorBorder:OutlineInputBorder(

                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0)),

                                              borderSide: BorderSide(
                                                  color: Colors.red, width: 1),


                                            ),

                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0)),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10,
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
                                            return controller.validateEmail(v!);

                                            },
                                          onSaved: (v) {controller.email=v!;
                                          },
                                          style: TextStyle(
                                            //: 40.0,
                                            height: 1.0,
                                          ),
                                          autocorrect: true,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,

                                          decoration: InputDecoration(

                                            hintText:
                                                'gmail.com@#########',
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
                                        height: 10,
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
                                                "كلمه المرور  ",
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
                                          //key: controller.registerFormkeyp,
                                               autovalidateMode: AutovalidateMode.onUserInteraction,
                                          controller: controller.passwordController,
                                          validator: (v) {
                                            return controller.validatePassword(v!);
                                          },
                                          onSaved: (v) {controller.password=v!;
                                          },
                                          style: TextStyle(
                                            //: 40.0,
                                            height: 1.0,
                                          ),
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                            errorStyle: TextStyle(),
                                            hintText: '***********',
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
                                        height: 20,
                                      ),



                                      Obx(()=>
                                      controller.isLoading.value == true ?
                                      const  Center(child:
                                      CircularProgressIndicator ()): const Text("")),

                                      MaterialButton(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 25),
                                        onPressed: () {
                                          controller.doRegister();
                                        },
                                        color: Themes.color,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          "انشاء حساب",
                                          style: Themes.button_text,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ]),
                                  ),
                                ),
                              )),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {},
                                    color: Colors.purple[50],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "انشاء حساب  ",
                                      style: Themes.select_option_text,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      Get.offNamed('/login');
                                    },
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "تسجيل دخول ",
                                      style: Themes.no_select_text,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ])


        ));
  }
}
