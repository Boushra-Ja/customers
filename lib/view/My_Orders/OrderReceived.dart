import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../logic/controllers/orders/OrdersController.dart';
import '../../main.dart';
import '../../models/Boshra/orders/OrderProduct.dart';
import '../../utls/Themes.dart';
import 'BillPage.dart';
import 'OrderDeatil.dart';

class OrderReceived extends StatelessWidget {
  final OrdersController controller = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: controller.recieved_orders.length == 0 ?  Center(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/notf.png'),
                      fit: BoxFit.contain),
                ),
              ),
              Text("لا يوجد طلبات مستلمة" , )
            ],
          ) ,
        ):ListView.builder(
            itemCount: controller.recieved_orders.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(right: 10, left: 10, bottom: 15),
                height: MediaQuery.of(context).size.height * 0.2,
                child: Material(
                  elevation: 2.0,
                  shadowColor: Themes.color2,
                  borderRadius: BorderRadius.circular(20.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(()=>
                          OrderDeatil( order_id: controller.recieved_orders[controller.recieved_orders.keys.elementAt(index)]!.order_id, index: index, status_id: controller.recieved_orders[controller.recieved_orders.keys.elementAt(index)]!.status_id,));
                    },
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Themes.color2, width: 2),
                      ),
                      selected: true,
                      selectedTileColor: Themes.grey_color,
                      contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                      leading: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage('${MyApp.api}/uploads/stores/${controller.recieved_orders[controller.recieved_orders.keys.elementAt(index)]!.store_image}'),
                              fit: BoxFit.contain),
                        ),
                      ),
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الطلب ${index + 1}",
                            style: Themes.headline1,
                          ),
                          Text(
                            "${ controller.recieved_orders[controller.recieved_orders.keys.elementAt(index)]!.store_name}",
                            style: Themes.subtitle1,
                          )
                        ],
                      ),
                      subtitle: Text(
                        "تم التسليم ${controller.recieved_orders[controller.recieved_orders.keys.elementAt(index)]!.delivery_time}",
                        style: Themes.subtitle3,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Get.to(()=>BillPage(controller.recieved_orders[controller.recieved_orders.keys.elementAt(index)]!.order_id  , index+1) );
                        },
                        icon: Icon(
                          Icons.payment,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
