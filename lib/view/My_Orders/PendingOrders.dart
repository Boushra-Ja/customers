import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controllers/orders/OrdersController.dart';
import '../../main.dart';
import '../../utls/Themes.dart';
import 'EditOrder.dart';
import 'OrderDeatil.dart';

class PendingOrders extends StatelessWidget {
  final OrdersController controller = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: controller.wating_orders.length == 0 ? Center(
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
              Text("لا يوجد طلبات معلقة" , )
            ],
          ) ,
        ) : ListView.builder(
            itemCount: controller.wating_orders.length,
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
                      Get.to(()=>OrderDeatil( order_id: controller.wating_orders[controller.wating_orders.keys.elementAt(index)]!.order_id, index: index,status_id: controller.wating_orders[controller.wating_orders.keys.elementAt(index)]!.status_id,));
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
                              image: NetworkImage('${MyApp.api}/uploads/stores/${ controller.wating_orders[controller.wating_orders.keys.elementAt(index)]!.store_image}'),
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
                            "${ controller.wating_orders[controller.wating_orders.keys.elementAt(index)]!.store_name}",
                            style: Themes.subtitle1,
                          )
                        ],
                      ),
                      subtitle: Text(
                        "تاريخ الطلب ${controller.wating_orders[controller.wating_orders.keys.elementAt(index)]!.created_at}",
                        style: Themes.subtitle3,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Get.to(()=>EditOrder(order_id: controller.wating_orders[controller.wating_orders.keys.elementAt(index)]!.order_id , status_id : controller.wating_orders[controller.wating_orders.keys.elementAt(index)]!.status_id ));
                        },
                        icon: Icon(
                          Icons.edit,
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
