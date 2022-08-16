import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../logic/controllers/DrawerController/GiftReqController.dart';
import '../../utls/Themes.dart';
import '../ConstantPages/MyCustomCLipper.dart';

class GiftRequest extends GetView<GiftReqController> {

  @override
  Widget build(BuildContext context) {
    final GiftReqController controller = Get.put(GiftReqController());

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Obx(
              (){
                if( controller.isLoading.value )
                  return  Center(child: CircularProgressIndicator(),);

                return ListView(
                  children: [
                    ClipPath(
                      child: Container(
                        color: Themes.color,
                        height: MediaQuery.of(context).size.height*0.11,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Themes.color2,
                                        child: Center(
                                          child: IconButton(
                                            onPressed: () {Get.back();},
                                            icon: Icon(
                                              Icons.arrow_back,
                                              color: Themes.color,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]))

                        ),
                      ),
                      clipper: MyCustomCLipper(),
                    ),
                    SizedBox(height: 20,),
                    Center(
                        child: Text(
                          "هل ترغب في إسعاد من تحب بهدية لطيفة ؟؟",
                          style: TextStyle(color: Themes.color),
                        )),
                    Center(
                        child: Text(
                          "ما عليك سوى تحديد المواصفات وسنساعدك باختيار الهدية",
                          style: TextStyle(color: Colors.grey),
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          new BoxShadow(
                            color: Themes.color2,
                          ),
                        ],
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "مناسبة الهدية",
                                        style: Themes.bodyText1,
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      child: Form(
                                        key: controller.formstate,
                                        child: TextFormField(
                                          //controller: controller.Gift_Occasion,
                                          keyboardType: TextInputType.text,
                                          validator: (val) {
                                          },
                                          onSaved: (val) {
                                            controller.set_gift_party(val) ;
                                          },
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(30)),
                                              hintText: 'ادخل هنا....',
                                              hintStyle: Themes.subtitle1,
                                              contentPadding: EdgeInsets.fromLTRB(
                                                  10.0, 0.01, 20.0, 0.01),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "مادة الصنع",
                                        style: Themes.bodyText1,
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      child: GetBuilder<GiftReqController>(builder: (GiftReqController controller){
                                        return  Form(
                                          key: controller.formstate3,
                                          child: DropdownButtonFormField(
                                            isDense: true,
                                            autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                            hint: Text("اختر"),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(30)),
                                                contentPadding: EdgeInsets.fromLTRB(
                                                    10, 0.001, 12, 0.001),
                                                filled: true,
                                                fillColor: Colors.white),
                                            onChanged: (newValue) {

                                            },
                                            onSaved: (val) {
                                              controller.setSelectedMaterial(val.toString()) ;
                                            },
                                            validator: (val) {

                                            },
                                            items:
                                            controller.Materiallist.keys.toList().map((item) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                  item,
                                                  textDirection: TextDirection.rtl,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                value: item,
                                              );
                                            }).toList(),
                                          ),
                                        ) ;
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 25,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "العمر المحدد",
                                        style: Themes.bodyText1,
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      //    height: 40,
                                        child: GetBuilder<GiftReqController>(builder: (GiftReqController controller){
                                          return Form(
                                            key: controller.formstate2,
                                            child: DropdownButtonFormField(
                                              isDense: true,
                                              autovalidateMode:
                                              AutovalidateMode.onUserInteraction,
                                              hint: Text("اختر" , style: Themes.subtitle3,),
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(30)),
                                                  contentPadding: EdgeInsets.fromLTRB(
                                                      10, 0.001, 12, 0.001),
                                                  filled: true,
                                                  fillColor: Colors.white),
                                              onSaved: (val){
                                                val == null ? controller.setSelectedAge(" ") : controller.setSelectedAge(val.toString()) ;

                                              },
                                              validator: (val) {

                                              },
                                              items: controller.AgeFromlist.map((item) {
                                                return DropdownMenuItem(
                                                  child: Text(
                                                    "$item",
                                                    textDirection: TextDirection.rtl,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  value: item,
                                                );
                                              }).toList(), onChanged: (String? value) {  },
                                            ),
                                          );
                                        })
                                    ),),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "السعر المناسب",
                                        style: Themes.bodyText1,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(child: Text("من" ,  style: Themes.bodyText1,
                                  ) , flex: 1,) ,
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                     // height: 40,
                                      child: Form(
                                        key: controller.formstate4,
                                        child: TextFormField(
                                          //controller: controller.Gift_Occasion,
                                          keyboardType: TextInputType.number,
                                          validator: (val) {

                                          },
                                          onSaved: (val) {
                                            val.toString().isEmpty ? controller.setFromPrice(0) : controller.setFromPrice(int.parse(val.toString())) ;
                                          },
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(30)),
                                              hintText: '0',
                                              hintStyle: Themes.subtitle1,
                                              contentPadding: EdgeInsets.fromLTRB(
                                                  10.0, 0.01, 20.0, 0.01),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),),
                                  Expanded(child: Text("  إلى" ,style: Themes.bodyText1,) , flex: 1,) ,
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                   //   height: 40,
                                      child: Form(
                                        key: controller.formstate5,
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          //controller: controller.Gift_Occasion,
                                          keyboardType: TextInputType.number,
                                          validator: (val) {
                                            return controller.validate_to() ;
                                          },
                                          onSaved: (val) {
                                            val.toString().isEmpty ? controller.setToPrice(0) : controller.setToPrice(int.parse(val.toString())) ;
                                          },
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(30)),
                                              hintText: '0',
                                              hintStyle: Themes.subtitle1,
                                              contentPadding: EdgeInsets.fromLTRB(
                                                  10.0, 0.01, 20.0, 0.01),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(child: SizedBox.shrink(), flex: 1,) ,

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/present.png'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.3,
                      ),
                      child: Obx(
                          (){
                            return controller.isLoad.value ? Center(child: CircularProgressIndicator(),) : MaterialButton(
                              onPressed: () {
                                controller.suggestion_prodcut() ;
                              },
                              color: Themes.color,
                              child: Text("الاقتراحات" , style: Themes.bodyText4,),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            );
                          }
                      )
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                );
              }
          )

        ));
  }
}
