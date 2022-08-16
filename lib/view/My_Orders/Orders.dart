import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controllers/AppBarController.dart';
import '../../logic/controllers/orders/OrdersController.dart';
import '../../utls/Themes.dart';
import '../ConstantPages/Drawer.dart';
import 'Accepted_Orders.dart';
import 'OrderReceived.dart';
import 'PendingOrders.dart';


class Orders extends StatelessWidget {
  final OrdersController controller_ = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppBarController>(
        init: AppBarController(),
        builder: (controller) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: Colors.white,
                key: controller.getscaffoldKey3(),
                drawer: myDrawer(),
                body: RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 3),
                            ()async {
                          if(controller_.index == 0)
                              await controller_.Fetch_WaitingOrders() ;
                          else if(controller_.index == 1)
                            await controller_.Fetch_AcceptOrders()  ;
                          else
                            await controller_.Fetch_RecievedOrders() ;
                          },
                      );
                    }, child:controller_.isLoading==false? Obx((){
                      return  Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Row(
                                children: [
                                  SizedBox(width: 5,),

                                  GetBuilder<AppBarController>(init : AppBarController(),builder: (controller){
                                    return IconButton(
                                        onPressed: () {
                                          controller.getscaffoldKey3().currentState!.openDrawer();
                                        },
                                        icon: Icon(
                                          Icons.menu,
                                          size: 35,
                                          color: Themes.color3,
                                        ));
                                  }) ,
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.65,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Themes.color3,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child:


                                    Row(children: [
                                      Expanded(child: IconButton(
                                        onPressed: () {
                                          print("search");
                                        },
                                        icon:  Icon(Icons.search ,  color: Themes.color3,
                                        ),
                                      ), flex: 1,
                                      ) ,
                                      Expanded(
                                        flex: 5,
                                        child:  Form(
                                          // key: _controller.formstate,
                                          child: TextFormField(
                                            cursorColor: Colors.grey,
                                            autofocus: false,
                                            enableInteractiveSelection: false,
                                            onChanged:(val){
                                            } ,
                                            decoration: new InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.only(left: 15, right: 15 , bottom: 5),
                                                hintText: "انقر هنا للبحث...."
                                            ),
                                            keyboardType: TextInputType.text,
                                            validator: (val) {
                                            },
                                            onSaved: (val) {
                                            },
                                            initialValue: "",
                                            style: Themes.subtitle2,

                                          ),
                                        ),

                                      )
                                    ]),
                                  ),
                                  SizedBox(width: 8,),
                                  IconButton(
                                      onPressed: () {Get.toNamed('/Cart');},
                                      icon: Icon(
                                        Icons.shopping_cart_outlined,
                                        size: 30,
                                        color: Themes.color3,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      controller_.setindex(0);
                                    },
                                    child: Column(
                                      children: [
                                        const Text(
                                          "المعلقة",
                                          textAlign: TextAlign.center,
                                        ),
                                        Divider(
                                          thickness:
                                          controller_.index == 0 ? 3 : 1,
                                          color: controller_.index == 0
                                              ? Themes.color
                                              : Colors.grey.shade200,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      controller_.setindex(1);
                                    },
                                    child: Column(
                                      children: [
                                        const Text(
                                          "المقبولة",
                                          textAlign: TextAlign.center,
                                        ),
                                        Divider(
                                          thickness:
                                          controller_.index == 1 ? 3 : 1,
                                          color: controller_.index == 1
                                              ? Themes.color
                                              : Colors.grey.shade200,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      controller_.setindex(2);
                                    },
                                    child: Column(
                                      children: [
                                        const Text(
                                          "المستلمة",
                                          textAlign: TextAlign.center,
                                        ),
                                        Divider(
                                          thickness:
                                          controller_.index == 2 ? 3 : 1,
                                          color: controller_.index == 2
                                              ? Themes.color
                                              : Colors.grey.shade200,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            controller_.index == 0
                                ? PendingOrders()
                                : controller_.index == 1
                                ? Accepted_Orders()
                                : OrderReceived()
                            /////////
                          ],
                        ),
                      );
                })
                :Center(
                  child: CircularProgressIndicator(),
                ),

                ),
              ));
        });
  }
}
