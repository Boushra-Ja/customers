import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controllers/orders/OrderDetailController.dart';
import '../../main.dart';
import '../../utls/Themes.dart';
import '../ConstantPages/MyCustomCLipper.dart';

class OrderDeatil extends StatelessWidget {

  int order_id , status_id;
  int index ;
  OrderDeatil({required this.order_id , required this.index , required this.status_id}) ;

  @override
  Widget build(BuildContext context) {
    final OrderDetailController controller = Get.put(OrderDetailController(order_id , status_id));

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body:RefreshIndicator(
              onRefresh: () {

                return Future.delayed(
                  Duration(seconds: 1),
                      () {
                    controller.fetch_order_products();
                  },
                );
              },
              child: Obx((){
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if( controller.order_products.isNotEmpty)
                {
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
                      Column(
                        children: [
                          Center(
                            child: Text(
                              "تفاصيل الطلب ${index+1}",
                              style: Themes.headline3,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "اسم المتجر  ${controller.order_products.elementAt(0).store_name}",
                                  style: Themes.bodyText3,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "تاريخ الطلب  ${controller.order_products.elementAt(0).order_time}",
                                  style: Themes.bodyText3,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "التاريخ المتوقع للتسليم  ${controller.order_products.elementAt(0).delivery_time}",
                                  style: Themes.bodyText3,
                                ),
                                SizedBox(
                                  height: 15,
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Text(
                              "محتوى الطلب",
                              style: Themes.headline3,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),

                          controller.order_products.isNotEmpty ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.order_products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(color: Themes.color2, width: 2),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  margin: EdgeInsets.only(right: 15, left: 15, bottom: 25),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "${controller.order_products.elementAt(index).product_name}",
                                                  style: Themes.headline1,
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: MediaQuery.of(context).size.height *
                                                    0.15,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image : NetworkImage(
                                                          '${MyApp.api}/uploads/product/${controller.order_products.elementAt(index).product_image}'),
                                                      fit: BoxFit.contain),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        controller.selected_options.containsKey(controller.order_products.elementAt(index).order_product_id) ? ListView.builder(
                                            shrinkWrap: true ,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: controller.selected_options[controller.order_products.elementAt(index).order_product_id]!.length,
                                            itemBuilder: (BuildContext context, int ind) {

                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 10.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "${controller.selected_options[controller.order_products.elementAt(index).order_product_id]?.elementAt(ind).name}",
                                                      style: Themes.bodyText3,
                                                    ),
                                                    Text("   ") ,
                                                    Text(
                                                      "${controller.selected_options[controller.order_products.elementAt(index).order_product_id]?.elementAt(ind).value}",
                                                      style: Themes.bodyText3,
                                                    ),
                                                  ],
                                                ),
                                              );}) : SizedBox.shrink(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "الكمية   ${controller.order_products.elementAt(index).amount} ",
                                          style: Themes.bodyText3,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }) : SizedBox.shrink(),

                          SizedBox(
                            height: 30,
                          )
                        ],
                      )
                    ],
                  );
                }
                return Center(
                  child:Column(
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
                      SizedBox(height: 100,),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
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
                );
              })

          )
        ));
  }
}
