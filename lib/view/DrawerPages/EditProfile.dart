import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controllers/DrawerController/EditProfileController.dart';
import '../../utls/Themes.dart';

class EditProfile extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
     return Directionality(textDirection: TextDirection.rtl, child: Scaffold(

      body: ListView(
        children: [

          SizedBox(
            height: 25,
          ),
          GetBuilder<EditProfileController>(
              init: EditProfileController(),
              builder: ( controller){
                if(controller.isLoading.value )
                  {
                    return Center(
                        child: CircularProgressIndicator(color: Themes.color, ) );
                  }
            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  InkWell(
                    onTap:() {
                      Get.defaultDialog(

                        title: "تحميل الصورة",
                        titleStyle: Themes.headline5,
                        content: Padding(
                          padding: EdgeInsets.only(left: 60 , right: 30),
                          child: Column(

                            children: [
                              InkWell(
                                onTap: ()async{
                                  controller.UploadImages(1) ;
                                },
                                child: Container(
                                 child: Row(
                                   children: [
                                     Text("من المعرض"),
                                     SizedBox(width: 50,),
                                     Icon(Icons.browse_gallery),
                                   ],
                                 ),
                                ),
                              ),
                              SizedBox(height: 20,) ,
                              InkWell(
                                onTap: ()async{
                                  controller.UploadImages(2) ;
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text("التقاط صورة"),
                                      SizedBox(width: 30,),
                                      Icon(Icons.camera),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        )
                      );
                    } ,
                    child: CircleAvatar(
                      child: Icon(Icons.person , size : 80 , color: Colors.white,),
                      radius: 80,
                      backgroundColor: Themes.color,
                    ),
                  ),
                  SizedBox(height: 30,) ,
                  Card(
                    color:Themes.grey_color ,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Themes.color2, width: 4),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Column(
                        children: [
                          Text("اسم المستخدم" , style: Themes.headline1,),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Expanded(child: SizedBox.shrink() , flex:  1,),
                              Expanded(
                                flex: 10,
                                child: GetBuilder<EditProfileController>(
                                  init: EditProfileController(),
                                  builder: ( controller) {
                                    return Form(
                                      key: controller.formstate,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      child: TextFormField(
                                        // controller: controller.name_controller,
                                        keyboardType: TextInputType.text,
                                        validator: (val) {
                                          return controller.validate_username(val) ;
                                        },
                                        onSaved: (val) {
                                          controller.set_username(val) ;
                                        },
                                        initialValue: controller.user_name,
                                        style: Themes.subtitle2,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(30)),
                                            hintText: "",
                                            hintStyle: Themes.subtitle1,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.0, 0.01, 20.0, 0.01),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    );
                                  },),
                              ),
                              Expanded(child: SizedBox.shrink() , flex:  1,)
                            ],
                          ),
                        ],
                      ),
                    ),

                  ),
                  SizedBox(height: 30,) ,
                  Card(
                    color:Themes.grey_color ,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Themes.color2, width: 4),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Column(
                        children: [
                          Text("البريد الالكتروني" , style: Themes.headline1,),
                          SizedBox(height: 10,) ,
                          Row(
                            children: [
                              Expanded(child: SizedBox.shrink() , flex:  1,),
                              Expanded(
                                flex: 10,
                                child: GetBuilder<EditProfileController>(
                                  init: EditProfileController(),
                                  builder: ( controller) {
                                    return Form(
                                      key: controller.formstate2,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      child: TextFormField(
                                        // controller: controller.name_controller,
                                        keyboardType: TextInputType.text,
                                        validator: (val) {
                                          return controller.validate_email(val) ;
                                        },
                                        onSaved: (val) {
                                          controller.set_email(val) ;
                                        },
                                        initialValue: controller.email,
                                        style: Themes.subtitle2,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(30)),
                                            hintText: "",
                                            hintStyle: Themes.subtitle2,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.0, 0.01, 20.0, 0.01),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    );
                                  },),
                              ),
                              Expanded(child: SizedBox.shrink() , flex:  1,),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30,) ,
                  Card(
                    color:Themes.grey_color ,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Themes.color2, width: 4),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap:(){
                              controller.check_pass.value ? controller.set_chechpass(false) : controller.set_chechpass(true);
                            } ,
                            child: Row(
                              children: [
                                Text("تعديل كلمة السر" , style: Themes.headline1,),
                                SizedBox(width: 40,) ,
                                Icon(Icons.arrow_drop_down)
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                          controller.check_pass.value ? SizedBox.shrink() :
                          Column(
                            children: [
                              Divider(),
                              SizedBox(height: 40,) ,
                              Text("كلمة السر القديمة" , style: Themes.headline1,),
                              SizedBox(height: 10,) ,
                              Row(
                                children: [
                                  Expanded(child: SizedBox.shrink() , flex:  1,),
                                  Expanded(
                                    flex: 10,
                                    child: GetBuilder<EditProfileController>(
                                      init: EditProfileController(),
                                      builder: ( controller) {
                                        return Form(
                                          key: controller.formstate3,
                                          child: TextFormField(
                                            // controller: controller.name_controller,
                                            keyboardType: TextInputType.text,
                                            validator: (val) {
                                              return controller.validateOldPassword(val) ;
                                            },
                                            onSaved: (val) {
                                            },
                                            style: Themes.subtitle2,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(30)),
                                                hintText: "********",
                                                hintStyle: Themes.subtitle2,
                                                contentPadding: EdgeInsets.fromLTRB(
                                                    10.0, 0.01, 20.0, 0.01),
                                                filled: true,
                                                fillColor: Colors.white),
                                          ),
                                        );
                                      },),
                                  ),
                                  Expanded(child: SizedBox.shrink() , flex:  1,),

                                ],
                              ),
                              SizedBox(height: 30,),
                              Text("كلمة السر الجديدة" , style: Themes.headline1,),
                              SizedBox(height: 10,) ,
                              Row(
                                children: [
                                  Expanded(child: SizedBox.shrink() , flex:  1,),
                                  Expanded(
                                    flex: 10,
                                    child: GetBuilder<EditProfileController>(
                                      init: EditProfileController(),
                                      builder: ( controller) {
                                        return Form(
                                          key: controller.formstate4,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          child: TextFormField(
                                            // controller: controller.name_controller,
                                            keyboardType: TextInputType.text,
                                            validator: (val) {
                                              return controller.validateNewPassword(val) ;
                                            },
                                            onSaved: (val) {
                                              controller.set_newpassword(val) ;
                                            },
                                            style: Themes.subtitle2,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(30)),
                                                hintText: "********",
                                                hintStyle: Themes.subtitle2,
                                                contentPadding: EdgeInsets.fromLTRB(
                                                    10.0, 0.01, 20.0, 0.01),
                                                filled: true,
                                                fillColor: Colors.white),
                                          ),
                                        );
                                      },),
                                  ),
                                  Expanded(child: SizedBox.shrink() , flex:  1,),

                                ],
                              ),
                              SizedBox(height: 20,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50,) ,
                  GetBuilder<EditProfileController>(
                      init: EditProfileController(),
                      builder: (controller){
                        return controller.isEdit.value ? MaterialButton(
                          onPressed: () async {
                            controller.editProfile() ;
                          } ,
                          height: 40,
                          minWidth: 100,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(20)),
                          child: Text("حفظ",
                              style:
                              TextStyle(color: Colors.white , fontSize: 16)),
                          color: Themes.color,
                        ) : Center(child: CircularProgressIndicator(),);
                      }),
                  SizedBox(height: 50,)
                ],
              ),
            );
          })
        ],
      ),
    )) ;
  }
}