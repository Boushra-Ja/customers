import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controllers/DrawerController/ReportPageController.dart';
import '../../models/Boshra/Store/NameModel.dart';
import '../../utls/Themes.dart';


class ReportPage extends GetView<ReportPageController> {
  final ReportPageController controller = Get.put(ReportPageController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Obx(() {
              if (controller.isLoading.value)
                return Center(
                  child: CircularProgressIndicator(),
                );

              return Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "اسم المتجر",
                              style: Themes.headline1,
                            )),
                        Expanded(
                            flex: 3,
                            child: Obx(
                                  () => Form(
                                key: controller.formstate2,
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10, 0.001, 12, 0.001),
                                        filled: true,
                                        fillColor: Colors.white),
                                    hint: Text(
                                      "اختر المتجر",
                                    ),
                                    validator: (val) {
                                      return controller.validate_shopname(val);
                                    },
                                    onChanged: (newValue) {
                                      controller.set_selectedshopname(
                                          (newValue as ShopName).name,
                                          (newValue as ShopName).id);
                                    },
                                    items: [
                                      for (var data in controller.shopsList)
                                        DropdownMenuItem(
                                          child: Text(
                                            "${data.name}",
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                            ),
                                          ),
                                          value: data,
                                        )
                                    ]),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "محتوى الشكوى",
                      style: Themes.bodyText1,
                      textAlign: TextAlign.start,
                    ),
                    GetBuilder<ReportPageController>(
                      init: ReportPageController(),
                      builder: (controller) {
                        return Form(
                          key: controller.formstate,
                          child: TextFormField(
                            minLines: 5,
                            maxLines: 7,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              return controller.validate_content(val);
                            },
                            onSaved: (val) {
                              controller.set_content(val);
                            },
                            initialValue: "",
                            style: Themes.subtitle2,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Themes.color),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'ادخل هنا....',
                                hintStyle: Themes.subtitle2,
                                contentPadding:
                                EdgeInsets.fromLTRB(10.0, 40, 20.0, 40),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GetBuilder<ReportPageController>(
                        init: ReportPageController(),
                        builder: (controller) {
                          return Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: controller.isReport.value ?FloatingActionButton.extended(
                              onPressed: () {
                                controller.report() ;
                              },
                              label: Text("إرسال"),
                              backgroundColor: Themes.color,
                              //icon: Icon(Icons.send , color: Themes.color2, size: 24,),
                            ) : Center(child: CircularProgressIndicator(),),
                          );
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/report.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ],
                ),
              );
            })));
  }
}
