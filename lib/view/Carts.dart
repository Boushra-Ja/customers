import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:slimy_card/slimy_card.dart';
import '../logic/controllers/DrawerController/SettingPageController.dart';
import '../logic/controllers/cart/CartController.dart';
import '../main.dart';
import '../models/Boshra/products/Option.dart';
import '../utls/Themes.dart';
import 'ConstantPages/MyCustomCLipper.dart';

class Carts extends GetView<CartController> {
  final sampleControllerr = Get.put(CartController());
  final sampleController3 = Get.put(SettingPageController(), permanent: true);

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return  Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              backgroundColor:sampleController3.col==0? Themes.white_color:
              Colors.black,

              body: GetX<CartController>(
                init: CartController(),
                  builder: (controller){
                if(!controller.isLoading.value)
                {
                  return Center(child: CircularProgressIndicator(),);
                }
                return  Center(
                        child:
                        controller.map1.isEmpty?
                        Center(
                          child: Column(
                            children: [
                              ClipPath(
                                child: Container(
                                  color: Themes.color,
                                  height: MediaQuery.of(context).size.height * 0.11,
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
                                                        // MdiIcons.cameraRear,
                                                        //  MdiIcons.chevronLeft,
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
                              SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.45,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/not.png'),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              Text("لا يوجد منتجات في السلة" ,style: Themes.headline1, )
                            ],
                          ) ,
                        )

                            :  Center(
                                child : GetBuilder<CartController>(
                                    builder: (controller) {
                                      return

                                        StreamBuilder(
                                          initialData: false,
                                          stream: slimyCard.stream,
                                          builder: ((BuildContext context, AsyncSnapshot snapshot) {
                                            return
                                              ListView(


                                                padding: EdgeInsets.zero,
                                                children: <Widget>[

                                                  Container(
                                                    margin: EdgeInsets.only(top: 30, right: 20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child:const  CircleAvatar(
                                                            radius: 20,
                                                            child: Icon(
                                                              Icons.arrow_back_rounded,
                                                              color: Themes.color,
                                                            ),
                                                            backgroundColor:
                                                            Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    margin: EdgeInsets.only(top: 1),
                                                    padding: new EdgeInsets.all(5.0),
                                                    child:

                                                    ListView.builder(
                                                        itemCount: controller.map1.length,
                                                        shrinkWrap: true,
                                                        physics:
                                                        NeverScrollableScrollPhysics(),
                                                        itemBuilder: (BuildContextcontext, int index) {
                                                          return
                                                            Column(
                                                              children: [

                                                                SizedBox(height: 30,),
                                                                Card(
                                                                  elevation: 10,
                                                                  shape:
                                                                  RoundedRectangleBorder(borderRadius:
                                                                  BorderRadius.circular(40),),
                                                                  child: Container(
                                                                    child: Card(
                                                                      elevation: 10,
                                                                      shape:
                                                                      RoundedRectangleBorder(borderRadius:
                                                                      BorderRadius.circular(30),),
                                                                      color : sampleController3.col==0? Themes.color2:
                                                                      Colors.black12,
                                                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                                                      child: Padding(
                                                                        padding : EdgeInsets.only( top: 1, bottom: 10),
                                                                        child: Column(
                                                                          children: [
                                                                            Center(
                                                                                child:
                                                                                Text("الطلب ${index+1}",
                                                                                  style: TextStyle(fontSize: 20,color: Colors.black),)
                                                                            ),
                                                                            SizedBox(height: 10,),
                                                                            Center(
                                                                                child: CircleAvatar(
                                                                                  radius: 65,
                                                                                  backgroundColor: Colors.white,
                                                                                  child: CircleAvatar(
                                                                                    radius: 60,
                                                                                    backgroundImage: NetworkImage((snapshot.data)
                                                                                        ? "${MyApp.api}/uploads/stores/${controller.map1.values.elementAt(index)[0].store_image}"
                                                                                        : "${MyApp.api}/uploads/stores/${controller.map1.values.elementAt(index)[0].store_image}"),
                                                                                  ),
                                                                                )),
                                                                            SizedBox(height: 10,),
                                                                            Row(
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Text("${controller.map1.values.elementAt(index)[0].store_name}",
                                                                                      style: Themes.subtitlebat),
                                                                                ),
                                                                              ],
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),


                                                                    ),
                                                                    height: MediaQuery.of(context).size.height*0.35,
                                                                    width: MediaQuery.of(context).size.width,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 20,),
                                                                Container(
                                                                  child:
                                                                  ListView.builder(
                                                                      itemCount: controller.map1.values.elementAt(index).length,
                                                                      shrinkWrap: true,
                                                                      physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                      itemBuilder: (BuildContextcontext, int i) {

                                                                        return Card(
                                                                          elevation: 10,
                                                                          shape:
                                                                          RoundedRectangleBorder(borderRadius:
                                                                          BorderRadius.circular(40),),
                                                                          margin: EdgeInsets.only(bottom: 20),
                                                                          child:
                                                                          Container(
                                                                            child: SlimyCard(
                                                                              width: MediaQuery.of(context).size.width/1.2,
                                                                              color : sampleController3.col==0? Themes.color2:
                                                                              Colors.black12,
                                                                              topCardHeight: MediaQuery.of(context).size.height*0.6,
                                                                              bottomCardHeight: MediaQuery.of(context).size.height*0.6,
                                                                              borderRadius: 30,
                                                                              slimeEnabled: true,
                                                                              topCardWidget: topCardWidget(index,context,i ),
                                                                              bottomCardWidget: bottomCardWidget(index, context,i),
                                                                            ),
                                                                          ),
                                                                        );

                                                                      }),



                                                                ),
                                                                SizedBox(height: 20,),
                                                                Container(
                                                                  margin:EdgeInsets.only(top: 20),
                                                                  width: MediaQuery.of(context).size.width ,

                                                                  child: Center(
                                                                    child: MaterialButton(
                                                                      onPressed: () {

                                                                        Get.toNamed('/treat_basket',
                                                                            arguments: {
                                                                              "map": controller.map1.values.elementAt(index),

                                                                            });



                                                                      },
                                                                      color: Colors.purple[50],
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          BorderRadius.circular(10)),
                                                                      child: Text(
                                                                        "معالجه الطلب ",
                                                                        style: Themes.subtitle2,
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ),

                                                                SizedBox(height: 30,)

                                                              ],
                                                            );
                                                        }),
                                                  ),
                                                  SizedBox(height: 30,)
                                                ],
                                              );
                                          }),

                                        );




                                    })
                            )
                        );

              })
             ));



  }


Widget topCardWidget(index, context,i) {
    print(controller.map1.values.elementAt(index)[i].gift_order);

  return Column(children: [
    SizedBox(height: 30,) ,
    Container(
      child: Card(
          color: sampleController3.col == 0 ? Colors.white : Colors.black12,
          child: Column(
            children: [


              Padding(
                  padding: const EdgeInsets.only(right: 30.0, bottom: 10 , top: 10),
                  child: Row(children: [
                    Icon(
                      Icons.circle_rounded,
                      color: Colors.black,
                      size: 8,
                    ),
                    Flexible(
                      child: Text(" اسم المنتج:   ", style: Themes.subtitlebat),
                    ),
                    Flexible(
                      child: Text(
                          "${controller.map1.values.elementAt(index)[i].product_name}",
                          style: Themes.subtitlebat),
                    ),
                  ])),
              Divider(
                color:
                sampleController3.col == 0 ? Colors.black12 : Colors.white,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Row(children: [
                  Icon(
                    Icons.circle_rounded,
                    color: Colors.black,
                    size: 8,
                  ),
                  Flexible(
                    child:
                    Text("  العدد المطلوب  :", style: Themes.subtitlebat),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(child: Text("${controller.map1.values.elementAt(index)[i].amount}")),
                ]),
              ),
              Divider(
                color:
                sampleController3.col == 0 ? Colors.black12 : Colors.white,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle_rounded,
                        color: Colors.black,
                        size: 8,
                      ),
                      Flexible(
                        child:
                        Text("السعر الاصلي : ", style: Themes.subtitlebat),
                      ),
                      Flexible(
                        child: Text(
                            "${controller.map1.values.elementAt(index)[i].selling_price}",
                            style: Themes.subtitlebat),
                      ),
                      Text(" ل.س  ", style: Themes.subtitlebat),
                    ],
                  )),

              Divider(
                color:
                sampleController3.col == 0 ? Colors.black12 : Colors.white,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle_rounded,
                        color: Colors.black,
                        size: 8,
                      ),
                      Flexible(
                        child: Text(" السعر بعد الخصم:   ",
                            style: Themes.subtitlebat),
                      ),

                      Flexible(child: Text("${(controller.map1.values.elementAt(index)[i].selling_after_dis)}", style: Themes.subtitlebat)),

                      Text(" ل.س  ", style: Themes.subtitlebat),
                    ],
                  )),
              Divider(
                color:
                sampleController3.col == 0 ? Colors.black12 : Colors.white,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),

              const SizedBox(
                height: 10,
              ),



            ],
          )),
    ),
  ]);
}

Widget bottomCardWidget(index, context,i) {
  return Column(
    children: [

      SizedBox(height: 20,) ,
      Padding(
        padding: const EdgeInsets.only(
            right: 20.0, bottom: 20, left: 20),        child: Center(
          child: Container(
            height: 30,
           child:  Row(
             children: <Widget>[
               Expanded(child: Text("تعديل الكمية") ,flex: 1,),
               SizedBox(width: 10,),
               Expanded(
                 flex: 1,
                 child: TextFormField(
                   initialValue: controller.map1.values.elementAt(index)[i].myamount == 0
                       ? "${controller.map1.values.elementAt(index)[i].amount}"
                       : "${controller.map1.values.elementAt(index)[i].myamount}",

                   onChanged: (text) => {
                     controller.map1.values.elementAt(index)[i].amount =int.parse(text),

                   },
                   textAlign: TextAlign.center,
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.all(8.0),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5.0),
                     ),
                   ),
                   // controller: I['controller{$index}'].text,
                   keyboardType: TextInputType.numberWithOptions(
                     decimal: false,
                     signed: true,
                   ),
                 ),
               ),
               Expanded(child: SizedBox.shrink() , flex:  1,)
             ],
           ),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(
            right: 20.0, bottom: 20, left: 20),        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Flexible(
                child: Text(
                  "تغليف المنتج",
                  style: Themes.subtitle1,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ), //SizedBox
                      GetBuilder<CartController>(builder: (CartController controller){
                        return  Radio(
                          activeColor: Themes.color,
                          onChanged: (value) {

                            controller.set_check(index, i) ;
                          },
                          groupValue: controller.map1.values.elementAt(index)[i].gift_order,
                          value: 'yes',
                        );
                      },) ,

                      SizedBox(width: 5),
                      Text(
                        'نعم',
                        style: Themes.subtitle2,
                      ),
                      SizedBox(width: 10), //
                      GetBuilder<CartController>(builder: (CartController controller){
                        return    Radio(
                            value: 'no',
                            activeColor: Themes.color,
                            groupValue: controller.map1.values.elementAt(index)[i].gift_order,
                            onChanged: (val) {
                              controller.set_check(index, i);
                            });
                      },) ,// SizedBox

                      SizedBox(width: 5),
                      Text(
                        'لا',
                        style: Themes.subtitle2,
                      ), //C
                    ], //<Widget>[]
                  ),
                ],
              ),
              //),
            ],
          ),
        ),
      ),

      ListView
          .builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.map1.values.elementAt(index)[i].options.length,
          itemBuilder: (BuildContext context, int ind) {
            return Padding(
              padding: const EdgeInsets.only(
                  right: 20.0, bottom: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        "${controller.map1.values.elementAt(index)[i].options.keys
                            .elementAt(ind)}",
                        style: Themes.subtitle1,
                      )),
                  Expanded(
                    flex: 3,
                    child: Container(
                        height: 35,
                        child: GetBuilder<CartController>(
                          init: CartController(),
                          builder:
                              (CartController controller) {

                            return DropdownButtonFormField(

                              isDense: true,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(30)),
                                  contentPadding: EdgeInsets
                                      .fromLTRB(
                                      10, 0.001, 12, 0.001),
                                  filled: true,
                                  fillColor: Colors.white),
                              onChanged: (newValue) {
                                controller.change_selectvalue(index,
                                    (newValue as Option).value_id ,  (newValue as Option).value , controller.map1.values.elementAt(index)[i].store_id , ind);
                              },
                              validator: (val) {
                                return controller
                                    .validate_value(val.toString());
                              },

                              items: controller.map1.values.elementAt(index)[i].options[
                              '${controller.map1.values.elementAt(index)[i].options.keys
                                  .elementAt(ind)}']
                                  ?.map((item) {

                                return DropdownMenuItem(

                                  child: Text(
                                    item.value,
                                    textDirection: TextDirection
                                        .rtl,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
                                  value: item,
                                );
                              }).toList(),
                            );
                          },
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(""),
                  )
                ],
              ),
            );
          }),


    ],
  );}



}
