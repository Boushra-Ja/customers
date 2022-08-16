import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../logic/controllers/orders/EditOrderController.dart';
import '../../main.dart';
import '../../utls/Themes.dart';
import '../ConstantPages/MyCustomCLipper.dart';

class EditOrder extends StatelessWidget {
  int order_id , status_id;
  EditOrder({required this.order_id , required this.status_id});

  @override
  Widget build(BuildContext context) {
    final EditOrderController controller =
        Get.put(EditOrderController(order_id , status_id));

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
            body: RefreshIndicator(onRefresh: () {
          return Future.delayed(
            Duration(seconds: 1),
            () {
              controller.fetch_order_products();
            },
          );
        }, child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            shrinkWrap: true,
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
              SizedBox(
                height: 20,
              ),
              controller.order_products.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.order_products.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int ind) {
                        return Card(
                          shape: BeveledRectangleBorder(
                            side: BorderSide(color: Themes.color2, width: 3),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          margin:
                              EdgeInsets.only(right: 15, left: 15, bottom: 25),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${MyApp.api}/uploads/product/${controller.order_products.elementAt(ind).product_image}'),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    "${controller.order_products.elementAt(ind).product_name}",
                                    style: Themes.headline1,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                // controller
                                //     .selected_options[controller
                                //     .order_products
                                //     .elementAt(ind)
                                //     .order_product_id]
                                //     ?.length != null ? ListView.builder(
                                //     shrinkWrap: true,
                                //     physics: NeverScrollableScrollPhysics(),
                                //     itemCount: controller
                                //         .selected_options[controller
                                //             .order_products
                                //             .elementAt(ind)
                                //             .order_product_id]
                                //         ?.length,
                                //     itemBuilder:
                                //         (BuildContext context, int index) {
                                //       return Padding(
                                //         padding: const EdgeInsets.only(
                                //             right: 20.0, bottom: 20, left: 20),
                                //         child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.start,
                                //           children: [
                                //             Expanded(
                                //                 flex: 2,
                                //                 child: Text(
                                //                   "${controller.selected_options[controller.order_products.elementAt(ind).order_product_id]?.elementAt(index).name}",
                                //                   style: Themes.bodyText1,
                                //                 )),
                                //             Expanded(
                                //               flex: 3,
                                //               child: Container(
                                //                   height: 35,
                                //                   child: GetBuilder<
                                //                       EditOrderController>(
                                //                     init: EditOrderController(
                                //                         order_id , status_id),
                                //                     builder:
                                //                         (EditOrderController
                                //                             controller) {
                                //                       print(controller
                                //                           .selected_options[
                                //                               controller
                                //                                   .order_products
                                //                                   .elementAt(
                                //                                       ind)
                                //                                   .order_product_id]
                                //                           ?.elementAt(index)
                                //                           .value_id);
                                //                       print(controller
                                //                           .selected_options[
                                //                               controller
                                //                                   .order_products
                                //                                   .elementAt(
                                //                                       ind)
                                //                                   .order_product_id]
                                //                           ?.elementAt(index)
                                //                           .value);
                                //
                                //                       return DropdownButtonFormField(
                                //                         //  value: controller.selected_options.elementAt(index).value,
                                //                         isDense: true,
                                //                         autovalidateMode:
                                //                             AutovalidateMode
                                //                                 .onUserInteraction,
                                //                         hint: Text("اختر"),
                                //                         decoration: InputDecoration(
                                //                             border: OutlineInputBorder(
                                //                                 borderRadius:
                                //                                     BorderRadius.circular(
                                //                                         30)),
                                //                             contentPadding:
                                //                                 EdgeInsets
                                //                                     .fromLTRB(
                                //                                         10,
                                //                                         0.001,
                                //                                         12,
                                //                                         0.001),
                                //                             filled: true,
                                //                             fillColor:
                                //                                 Colors.white),
                                //                         onChanged: (newValue) {
                                //                           controller.change_value(
                                //                               newValue,
                                //                               controller
                                //                                   .order_products
                                //                                   .elementAt(
                                //                                       ind)
                                //                                   .order_product_id,
                                //                               index);
                                //                           print(controller
                                //                               .selected_options[
                                //                                   controller
                                //                                       .order_products
                                //                                       .elementAt(
                                //                                           ind)
                                //                                       .order_product_id]
                                //                               ?.elementAt(index)
                                //                               .value_id);
                                //                         },
                                //
                                //                         items: controller
                                //                             .options[
                                //                                 controller
                                //                                     .order_products
                                //                                     .elementAt(
                                //                                         ind)
                                //                                     .product_id]
                                //                                 ?[
                                //                                 '${controller.selected_options[controller.order_products.elementAt(ind).order_product_id]?.elementAt(index).name}']
                                //                             ?.map((item) {
                                //                           // print("select" + controller.selected_options.elementAt(index).value) ;
                                //                           // print("item " + item.value) ;
                                //                           return DropdownMenuItem(
                                //                             child: Text(
                                //                               item.value,
                                //                               textDirection:
                                //                                   TextDirection
                                //                                       .rtl,
                                //                               textAlign:
                                //                                   TextAlign
                                //                                       .start,
                                //                               style:
                                //                                   const TextStyle(
                                //                                 fontWeight:
                                //                                     FontWeight
                                //                                         .w300,
                                //                                 color: Colors
                                //                                     .black,
                                //                               ),
                                //                             ),
                                //                             value: item,
                                //                           );
                                //                         }).toList(),
                                //                       );
                                //                     },
                                //                   )),
                                //             ),
                                //             Expanded(
                                //               flex: 1,
                                //               child: Text(""),
                                //             )
                                //           ],
                                //         ),
                                //       );
                                //     }) : SizedBox.shrink(),

                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 20.0, bottom: 20, left: 20),
                                  child: GetBuilder<EditOrderController>(
                                    builder: (EditOrderController controller){
                                    return  Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                "الكمية",
                                                style: Themes.bodyText1,
                                              )),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child:Form(
                                                key: controller.formstate.elementAt(ind),
                                                child: TextFormField(
                                                    initialValue: controller. order_products.elementAt(ind).amount,
                                                    keyboardType: TextInputType.text,
                                                    validator: (val) {
                                                      if(val!.isEmpty)
                                                        return "مطلوب" ;
                                                      return null ;
                                                    },
                                                    onSaved: (val) {
                                                      controller.set_quantity(val , ind) ;
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
                                      );
                                  },)
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20.0, bottom: 20, left: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "تغليف المنتج",
                                        style: Themes.subtitle1,
                                      ) ,
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 10,
                                          ), //SizedBox
                                          GetBuilder<EditOrderController>(builder: (EditOrderController controller){return Radio(
                                            activeColor: Themes.color,
                                            onChanged: (value) {
                                              controller.setchexkboxValue(
                                                  value.toString() , ind);
                                              print(controller. order_products.elementAt(ind).gift_order);

                                            },
                                            groupValue: controller.order_products.elementAt(ind).gift_order,
                                            value: "yes",
                                          );})
                                          ,SizedBox(width: 5),
                                          Text(
                                            'نعم',
                                            style: Themes.subtitle2,
                                          ),
                                          SizedBox(width: 10), //SizedBox
                                          GetBuilder<EditOrderController>(builder: (EditOrderController controller){
                                            return Radio(
                                                value: "no",
                                                activeColor: Themes.color,
                                                groupValue: controller. order_products.elementAt(ind).gift_order,
                                                onChanged: (val) {
                                                  controller.setchexkboxValue(
                                                      val.toString() , ind);
                                                  print(controller. order_products.elementAt(ind).gift_order);
                                                }) ;
                                          }) ,
                                          SizedBox(width: 5),
                                          Text(
                                            'لا',
                                            style: Themes.subtitle2,
                                          ), //C
                                        ], //<Widget>[]
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox.shrink(),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () async {
                                          // await controller.edit_options(
                                          //     controller.order_products
                                          //         .elementAt(ind)
                                          //         .order_product_id);

                                          await controller.edit_order_product(ind) ;
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text("تعديل",
                                            style:
                                                TextStyle(color: Themes.color)),
                                        color: Themes.color2,
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: SizedBox.shrink(),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () async {
                                          await controller.delete_product(
                                               controller.order_products
                                                   .elementAt(ind)
                                                   .order_product_id);
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text("حذف",
                                            style:
                                                TextStyle(color: Themes.color)),
                                        color: Themes.color2,
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: SizedBox.shrink(),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(
                      child:Column(
                        children: [
                          SizedBox(height: 50,),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/notf.png'),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          SizedBox(height: 20,) ,
                          Text('لا يوجد طلبات معلقة حالياً' , style: Themes.bodyText3,)
                        ],
                      ),
                    ),

            ],
          );
        }))));
  }
}
