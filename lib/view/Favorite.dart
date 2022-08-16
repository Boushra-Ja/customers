import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../logic/controllers/AppBarController.dart';
import '../logic/controllers/DrawerController/SettingPageController.dart';
import '../logic/controllers/FavoriteController.dart';
import '../utls/Themes.dart';
import '../../../main.dart';
import 'ConstantPages/Drawer.dart';
import 'ProductDeatil.dart';
import 'ShopsPages/ShopProfile.dart';

class Favorite extends GetView<FavoriteController> {
  var check_tap;
  final sampleControllerr = Get.put(FavoriteController(), permanent: true);
  final sampleController3 = Get.put(SettingPageController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppBarController>(
        init: AppBarController(),
        builder: (controller2) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child:
              GetX<SettingPageController>(
              builder: (c) => Scaffold(
                backgroundColor:   sampleController3.col==0?Colors.white:
                  Colors.black,

                  key: controller2.getscaffoldKey4(),
                  drawer: myDrawer(),
                  body: GetX<FavoriteController>(
                      builder: (c) => Center(
                          child: c.listfavoite.isEmpty &&  c.check.value=='DATA'
                              ? Center(child: CircularProgressIndicator()):
                         GetX<FavoriteController>(
                               builder: (c) => Center(
                                  child:  c.listfavoite.isEmpty &&  c.check.value=='DATA'
                                      ? CircularProgressIndicator()
                                      : GetBuilder<FavoriteController>(
                                      builder: (controller) {
                                        return
                                          RefreshIndicator(
                                            onRefresh: () {

                                              return Future.delayed(
                                                Duration(seconds: 1),
                                                    () {
                                                        controller.FetchData_favorite();
                                                        controller.FetchData_favorite_store();
                                                },
                                              );
                                            },
                                            child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: GetBuilder<FavoriteController>(
                                              init: FavoriteController(),
                                              builder: (controller) {
                                                return Column(children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 40.0),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 5,),

                                                        GetBuilder<AppBarController>(init : AppBarController(),builder: (controller){
                                                          //controller.hh();
                                                          return IconButton(
                                                              onPressed: () {
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
                                                  ) ,
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.width * 0.5,
                                                        child: InkWell(
                                                          child: Container(
                                                              child: Center(
                                                                child: Column(
                                                                  children: [
                                                                    Text("المنتجات",
                                                                        style: controller.Tabbar.value == 2 && sampleController3.col==0

                                                                            ? TextStyle(color:Colors.grey,fontSize: 12)
                                                                            :  controller.Tabbar.value == 1 && sampleController3.col==0?
                                                                        TextStyle(color:Colors.black,fontSize: 12)

                                                                            ////////////////////////////////////////////////////

                                                                            :
                                                                        controller.Tabbar.value == 2 && sampleController3.col==1

                                                                            ? TextStyle(color:Colors.grey,fontSize: 12):
                                                                           // :  controller.Tabbar.value == 1 && sampleController3.col==1
                                                                        TextStyle(color:Colors.white,fontSize: 12),




                                                                        textAlign: TextAlign.center),
                                                                    Divider(
                                                                      thickness:
                                                                      controller.Tabbar.value == 1
                                                                          ? 4
                                                                          : 1,
                                                                      color: controller.Tabbar.value == 1 &&  sampleController3.col==0
                                                                          ? Themes.color
                                                                          : controller.Tabbar.value == 0 &&  sampleController3.col==0?
                                                                      Colors.grey.shade200:


                                                                          ////////////////////////////////////

                                                                      controller.Tabbar.value == 1 &&  sampleController3.col==1
                                                                          ? Colors.white
                                                                          :
                                                                      //controller.Tabbar.value == 0 &&  sampleController3.col==0?

                                                                      Colors.grey.shade200


                                                                      // indent: MediaQuery.of(context).size.width * 0.5
                                                                    )
                                                                  ],
                                                                ),
                                                              )),
                                                          onTap: () {
                                                            controller.Tabbar.value = 1;
                                                            controller.changeTabbar(1);
                                                            print(controller.Tabbar.value);
                                                          },
                                                        )),
                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.width * 0.5,
                                                        child: InkWell(
                                                          child: Container(
                                                              child: Center(
                                                                child: Column(
                                                                  children: [
                                                                    Text("المتاجر",
                                                                        style: controller.Tabbar.value == 2 && sampleController3.col==0
                                                                            ? TextStyle(color:Colors.black,fontSize: 12):
                                                                             controller.Tabbar.value == 1 && sampleController3.col==0?
                                                                             TextStyle(color:Colors.grey,fontSize: 12):



                                                                                 /////////////////////////////



                                                                             controller.Tabbar.value == 2 && sampleController3.col==1
                                                                                 ? TextStyle(color:Colors.white,fontSize: 12):
                                                                             TextStyle(color:Colors.grey,fontSize: 12),

                                                                             textAlign: TextAlign.center),
                                                                    Divider(
                                                                      thickness:
                                                                      controller.Tabbar.value == 2
                                                                          ? 3
                                                                          : 1,
                                                                      color: controller.Tabbar.value == 2 && sampleController3.col==0
                                                                          ? Themes.color
                                                                          :controller.Tabbar.value == 1 && sampleController3.col==0?
                                                                           Colors.grey.shade200:


                                                                      /////////////////////////////////////

                                                                      controller.Tabbar.value == 2 && sampleController3.col==1
                                                                          ? Colors.white
                                                                          :
                                                                      Colors.grey.shade200


                                                                    )
                                                                  ],
                                                                ),
                                                              )),
                                                          onTap: () {

                                                            controller.Tabbar.value = 2;
                                                            controller.changeTabbar(2);
                                                          },
                                                        ))
                                                  ]),
                                                  SizedBox(
                                                    height: 20,
                                                  ),

                                                  /////////////////////////////
                                                  controller.Tabbar.value == 2 &&
                                                  c.listfavoitestore.isNotEmpty ? Flexible(
                                                    child:
                                                    GridView.builder(

                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      itemCount: c.listfavoitestore.length,
                                                      itemBuilder: (ctx, i) {
                                                        return

                                                          Container(

                                                            child: Column(
                                                              children: [

                                                                InkWell(
                                                                  onTap: () {
                                                                    Get.to(ShopProfile(controller.listfavoitestore.elementAt(i).store_id));
                                                                  },
                                                                  child: Center(
                                                                    child:

                                                                    CircleAvatar(
                                                                      radius: 50,
                                                                      backgroundImage:
                                                                      NetworkImage(
                                                                        "${MyApp.api}/uploads/stores/${c.listfavoitestore.elementAt(i).image}",

                                                                      ),
                                                                    ),

                                                                  ),
                                                                ),

                                                                Container(
                                                                  margin:
                                                                  EdgeInsets.only(right: 40),
                                                                  child: Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: () {

                                                                          Get.to(ShopProfile(controller.listfavoitestore.elementAt(i).store_id));
                                                                        },
                                                                        child: Text("  "+
                                                                            c.listfavoitestore.elementAt(i).shop_name,
                                                                            style:
                                                                                sampleController3.col==0?
                                                                            Themes.subtitle2:
                                                                                    TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      Icon(
                                                                        Icons.star_outline_rounded,
                                                                        color: Colors.blue,
                                                                        size: 20,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                                c.listfavoitestore.elementAt(i).review==0?
                                                                Container(
                                                                    margin:
                                                                    EdgeInsets.only(right: 40),
                                                                    child: Row(
                                                                      children: const [
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        )
                                                                      ],
                                                                    )) :
                                                                c.listfavoitestore.elementAt(i).review==1 ?
                                                                Container(
                                                                    margin:
                                                                    EdgeInsets.only(right: 40),
                                                                    child: Row(
                                                                      children: const [
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        )
                                                                      ],
                                                                    )) :
                                                                c.listfavoitestore.elementAt(i).review==2 ?
                                                                Container(
                                                                    margin:
                                                                    EdgeInsets.only(right: 40),
                                                                    child: Row(
                                                                      children: const [
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        )
                                                                      ],
                                                                    )) :
                                                                c.listfavoitestore.elementAt(i).review==3 ?
                                                                Container(
                                                                    margin:
                                                                    EdgeInsets.only(right: 40),
                                                                    child: Row(
                                                                      children: const [
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        )
                                                                      ],
                                                                    )):
                                                                c.listfavoitestore.elementAt(i).review==4 ?
                                                                Container(
                                                                    margin:
                                                                    EdgeInsets.only(right: 40),
                                                                    child: Row(
                                                                      children: const [
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        )
                                                                      ],
                                                                    )):
                                                                Container(
                                                                    margin:
                                                                    EdgeInsets.only(right: 40),
                                                                    child: Row(
                                                                      children: const [
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.yellow,
                                                                          size: 15,
                                                                        ),
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Colors.pink,
                                                                          size: 15,
                                                                        )
                                                                      ],
                                                                    ))


                                                              ],
                                                            ),
                                                            //   ],
                                                            // ),
                                                          );

                                                      },
                                                      gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                      ),
                                                    ),
                                                  ) :
                                                  controller.Tabbar.value != 2 &&
                                                      c.listfavoite.isNotEmpty? Flexible(
                                                    child:

                                                    GridView.builder(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      itemCount: c.listfavoite.length,

                                                      itemBuilder: (ctx, index) {
                                                        return Container(
                                                          width: MediaQuery.of(context).size.width *
                                                              0.5,
                                                          margin: EdgeInsets.all(5),
                                                          padding: EdgeInsets.all(5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.stretch,
                                                            children: [
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Get.to(ProductDeatil(controller.listfavoite.elementAt(index).id));
                                                                  },
                                                                  child: Center(
                                                                    child:  Image  .network(
                                                                      "${MyApp.api}/uploads/product/${c.listfavoite
                                                                          .elementAt(
                                                                          index)
                                                                          .image}",
                                                                      fit:BoxFit
                                                                          .cover ,
                                                                    ),

                                                                  ),
                                                                ),
                                                              ),
                                                              Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Get.to(ProductDeatil(controller.listfavoite.elementAt(index).id));
                                                                  },
                                                                  child: Text(
                                                                    "${c.listfavoite.elementAt(index).product_name}",
                                                                    style:
                                                                    sampleController3.col==0?
                                                                    Themes.subtitle2:
                                                                    TextStyle(color: Colors.white),),



                                                                ),
                                                              ),
                                                              Container(
                                                                  child: Row(
                                                                    children: [

                                                                      Text(
                                                                        "${c.listfavoite.elementAt(index).review}" + " تقييم",

                                                                         style:
                                                                      sampleController3.col==0?
                                                                      Themes.subtitle2:
                                                                      TextStyle(color: Colors.white),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 4,
                                                                      ),
                                                                      Icon(
                                                                        Icons.tag_faces_outlined,
                                                                        color: Colors.orange,
                                                                        size: 12,
                                                                      ),

                                                                    ],
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.center,
                                                                  )),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        mainAxisSpacing: 50,
                                                        mainAxisExtent: 200,
                                                      ),
                                                    ),


                                                  ) : Center(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 40,),
                                                        Icon(Icons.favorite_border , size: 100, color: Colors.grey,),
                                                        Text("لا يوجد عناصر في المفضلة" , style: Themes.headline1,)
                                                      ],
                                                    ) ,
                                                  )

                                                ]);
                                              },
                                            ),
                                        ),
                                          );
                                      })))))



              )));
        });
  }
}
