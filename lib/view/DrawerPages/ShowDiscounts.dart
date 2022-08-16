import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controllers/orders/DisountController.dart';
import '../../utls/Themes.dart';
import '../ConstantPages/MyCustomCLipper.dart';
import '../ShopsPages/ShopProfile.dart';

class ShowDiscounts extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    DiscountController controller = Get.put(DiscountController());
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Themes.color2,
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Obx(() {
                  return !controller.isLoading.value
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : controller.discount_list.length == 0 ? Center(
                    child: Column(
                      children: [
                        ClipPath(
                          child: Container(

                            color: Themes.color,
                            height: MediaQuery.of(context).size.height * 0.12,
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
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: Icon(
                                                  Icons.arrow_back,
                                                  color: Themes.color,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]))),
                          ),
                          clipper: MyCustomCLipper(),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                        Container(
                          height:
                          MediaQuery.of(context).size.height * 0.35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/discount.jpg'),
                                fit: BoxFit.contain),
                          ),
                        ),
                        Center(child: Text("لا يوجد خصومات متاحة" , style: Themes.headline1,))
                      ],
                    ),
                  ) :Stack(
                    children: [
                      Center(
                        child: Container(
                            height:
                            MediaQuery.of(context).size.height ,
                          width :MediaQuery.of(context).size.width ,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/discount.jpg'),
                                  fit: BoxFit.contain),
                            ),
                          ),
                      ),

                       ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: controller.discount_list.length,
                              itemBuilder: (BuildContext, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0 , vertical: 20),
                                  child: Container(

                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        40,

                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey
                                                .withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius:3,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        color: Colors.white.withOpacity(0.6)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Get.to(ShopProfile(controller.discount_list.elementAt(index).store_id)) ;
                                            },
                                            child: Text(
                                              "خصم من ${controller.discount_list.elementAt(index).store_name}",
                                              style: Themes.headline5,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "قيمة الخصم ${controller.discount_list.elementAt(index).value} %",
                                            style: Themes.subtitle1,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "وقت انتهاء الخصم  ${controller.discount_list.elementAt(index).end_date}",
                                            style: Themes.subtitle1,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                    ],
                  );
                }))));
  }
}