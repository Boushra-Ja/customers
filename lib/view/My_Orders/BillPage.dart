import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controllers/orders/BillController.dart';
import '../../utls/Themes.dart';

class BillPage extends StatelessWidget {
  int order_id, index;

  BillPage(this.order_id, this.index);

  @override
  Widget build(BuildContext context) {
    print(order_id);
    final BillController controller = Get.put(BillController(order_id));

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: RefreshIndicator(onRefresh: () {
          return Future.delayed(
            Duration(seconds: 1),
            () {
              controller.fetch_bill();
            },
          );
           }, child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return controller.products_bill.isNotEmpty ? ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 15.0, top: 10, bottom: 10),
                child: Align(
                    child: CircleAvatar(
                      radius: 18,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Themes.color,
                        ),
                      ),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    alignment: Alignment.topRight),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "الطلب ${index}",
                          style: Themes.headline3,
                        ),
                      ),
                      Center(
                        child: Text(
                          "تاريخ الفاتورة  ${controller.products_bill.elementAt(0).delivery_time}",
                          style: Themes.subtitle2,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "البائع",
                        style: Themes.headline2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "اسم المتجر    ${controller.products_bill.elementAt(0).store_name}",
                        style: Themes.bodyText3,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "المشتري",
                        style: Themes.headline2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "اسم الزبون     ${controller.products_bill.elementAt(0).customer_name}",
                        style: Themes.bodyText3,
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text("المنتح"),
                            flex: 4,
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 2,
                          ),
                          Expanded(
                            child: Text("الكمية"),
                            flex: 4,
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 2,
                          ),
                          Expanded(
                            child: Text("السعر"),
                            flex: 4,
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                        ],
                      ),
                      Divider(),
                      ListView.builder(
                          itemCount: controller.products_bill.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox.shrink(),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${controller.products_bill.elementAt(index).product_name}",
                                        style: Themes.subtitle2,
                                      ),
                                      flex: 4,
                                    ),
                                    Expanded(
                                      child: SizedBox.shrink(),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${controller.products_bill.elementAt(index).amount}",
                                        style: Themes.subtitle2,
                                      ),
                                      flex: 4,
                                    ),
                                    Expanded(
                                      child: SizedBox.shrink(),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${controller.products_bill.elementAt(index).selling_price}",
                                        style: Themes.subtitle2,
                                      ),
                                      flex: 4,
                                    ),
                                    Expanded(
                                      child: SizedBox.shrink(),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                                Divider()
                              ],
                            );
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          'الخصومات المتاحة للمنتجات',
                          style: Themes.headline2,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          itemCount: controller.products_bill.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                controller.products_bill
                                            .elementAt(index)
                                            .discount_value !=
                                        0
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox.shrink(),
                                            flex: 2,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${controller.products_bill.elementAt(index).product_name}",
                                              style: Themes.subtitle2,
                                            ),
                                            flex: 4,
                                          ),
                                          Expanded(
                                            child: SizedBox.shrink(),
                                            flex: 1,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${controller.products_bill.elementAt(index).discount_value} %",
                                              style: Themes.subtitle2,
                                            ),
                                            flex: 2,
                                          ),
                                          Expanded(
                                            child: SizedBox.shrink(),
                                            flex: 2,
                                          ),
                                        ],
                                      )
                                    : Center(
                                  child: Text("لم يتم تطبيق أي خصم" , style: Themes.subtitle3,),
                                ),
                                controller.products_bill
                                            .elementAt(index)
                                            .discount_value !=
                                        0
                                    ? Divider()
                                    : SizedBox.shrink()
                              ],
                            );
                          }),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                          Expanded(
                            ////اذا كان عليه كود حسم
                            child: Text(
                              "خصم الفاتورة الكلي ",
                              style: Themes.subtitle2,
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              " ${controller.products_bill.elementAt(0).discount_customer_value} %",
                              style: Themes.subtitle2,
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              "المجموع",
                              style: Themes.subtitle2,
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              "${controller.total_price}",
                              style: Themes.subtitle2,
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              "المبلغ المطلوب",
                              style: Themes.subtitle2,
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              "${controller.price_after_discount} ل.س",
                              style: Themes.subtitle2,
                            ),
                            flex: 5,
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/bill1.png'),
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ) : SizedBox.shrink();
        }))));
  }
}
