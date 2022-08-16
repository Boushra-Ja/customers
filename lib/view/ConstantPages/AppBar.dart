import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controllers/AppBarController.dart';
import '../../utls/Themes.dart';


class myAppBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        children: [
          SizedBox(width: 5,),

          GetBuilder<AppBarController>(init : AppBarController(),builder: (controller){
              //controller.hh();
            return IconButton(
                onPressed: () {

                   controller.getscaffoldKey().currentState!.openDrawer();
                   controller.getscaffoldKey2().currentState!.openDrawer();
                   controller..getscaffoldKey3().currentState!.openDrawer();
                   controller..getscaffoldKey4().currentState!.openDrawer();

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
              IconButton(
                onPressed: () {
                  print("search");
                },
                icon:  Icon(Icons.search ,  color: Themes.color3,
                ),
              ),
              Text(" انقر هنا للبحث ..."),
            ]),
          ),



          SizedBox(width: 8,),
          IconButton(
              onPressed: () {
                Get.toNamed('/Cart');},
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: Themes.color3,
              )),
        ],
      ),
    ) ;

  }
}
