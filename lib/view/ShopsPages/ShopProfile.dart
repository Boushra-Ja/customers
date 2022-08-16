import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import '../../logic/controllers/ShopsController/ShopProfileController.dart';
import '../../main.dart';
import '../../utls/Themes.dart';
import '../ProductDeatil.dart';
import '../Seggestions.dart';


class ShopProfile extends StatelessWidget {
  final shop_id;

  ShopProfile(this.shop_id);

  @override
  Widget build(BuildContext context) {
    final ShopProfileController _controller =
    Get.put(ShopProfileController(shop_id));

    return Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
              backgroundColor: Colors.white,
              body: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(
                    Duration(seconds: 3),
                        () {
                      _controller.fetchShopInfo() ;
                    },
                  );
                }, child: Obx(() {
                if (_controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return LayoutBuilder(builder: (_, constraints) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3 + 10,
                        child: Stack(
                          children: [
                            CustomPaint(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                              ),
                              painter: HeaderCurvedContainer(),
                            ),
                            Positioned(
                                top: 80,
                                right: 20,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('${MyApp.api}/uploads/stores/${_controller.shop_info.image}'),
                                  radius: 70,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 45),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_controller.shop_info.shop_name}",
                                  style: Themes.headline1,
                                ),
                                Row(
                                  children: [
                                    Text("عدد المبيعات  "),
                                    Text(
                                      "${_controller.shop_info.num_of_salling}",
                                      style: Themes.subtitle2,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: _controller.shop_info.review >= 1
                                          ? Colors.yellow.shade700
                                          : Themes.color,
                                      size: 18,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: _controller.shop_info.review >= 2
                                          ? Colors.yellow.shade700
                                          : Themes.color,
                                      size: 18,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: _controller.shop_info.review >= 3
                                          ? Colors.yellow.shade700
                                          : Themes.color,
                                      size: 18,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: _controller.shop_info.review >= 4
                                          ? Colors.yellow.shade700
                                          : Themes.color,
                                      size: 18,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: _controller.shop_info.review == 5
                                          ? Colors.yellow.shade700
                                          : Themes.color,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                            ),
                            GetBuilder<ShopProfileController>(
                              init: ShopProfileController(shop_id),
                              builder: (ShopProfileController controller) {
                                return InkWell(
                                    onTap: () {
                                      controller.shop_info.isFavourite == false ? controller.addToFavouriteStore() :  controller.deleteFromFavourite() ;
                                    },
                                    child:
                                    CircleAvatar(
                                      radius: 20,
                                      child:  Icon(
                                        Icons.favorite,
                                        color: controller.shop_info.isFavourite ? Colors.red :  Colors.grey,
                                      ),
                                      backgroundColor: Colors.grey.shade200,
                                    )

                                );
                              },)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text("${_controller.shop_info.discription}"),
                      ),
                      const Divider(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Center(
                        child: Text(
                          "للتواصل مع المتجر",
                          style: Themes.headline2,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: [
                            _controller.shop_info.mobile == null ? SizedBox.shrink() : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                const Icon(
                                  Icons.call,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                ),
                                Text("${_controller.shop_info.mobile}",
                                    style: Themes.bodyText1)
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _controller.shop_info.email == null ? SizedBox.shrink() :Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                const Icon(
                                  Icons.email,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                                Flexible(
                                  child: Text("${_controller.shop_info.email}",
                                      style: Themes.bodyText1),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _controller.shop_info.facebook == null ? SizedBox.shrink() :Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                const Icon(
                                  Icons.facebook,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                                Flexible(
                                  child: Text("${_controller.shop_info.facebook}",
                                      style: Themes.bodyText1),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.delivery_dining ,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                                Flexible(
                                  child: Text("${_controller.shop_info.area}",
                                      style: Themes.bodyText1),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GetBuilder<ShopProfileController>(
                        init: ShopProfileController(shop_id),
                        builder: (controller) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.setcheck_tap(true);
                                    },
                                    child: SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.5,
                                      child: Column(
                                        children: [
                                          const Text(
                                            "المنتجات",
                                            textAlign: TextAlign.center,
                                          ),
                                          Divider(
                                            thickness: controller.check_tap.value
                                                ? 3
                                                : 1,
                                            color: controller.check_tap.value
                                                ? Themes.color
                                                : Colors.grey.shade200,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.setcheck_tap(false);
                                    },
                                    child: SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.5,
                                      child: Column(
                                        children: [
                                          Text("التقييمات",
                                              textAlign: TextAlign.center),
                                          Divider(
                                            thickness: !controller.check_tap.value
                                                ? 3
                                                : 1,
                                            color: !controller.check_tap.value
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
                              /////////
                              !controller.check_tap.value
                                  ?  Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: controller.shop_info.all_review.length != 0 ?    Card(
                                    shape: BeveledRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    child:
                                    GetBuilder<ShopProfileController>(builder: (ShopProfileController controller){
                                      return Column(
                                        children: [
                                          ListView.builder(
                                              itemCount:
                                              controller.shop_info.all_review.length >= 4 ? controller.size_list.value : controller.shop_info.all_review.length,
                                              shrinkWrap: true,
                                              physics:
                                              NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                  int index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      ListTile(
                                                        title: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              "${_controller.shop_info.all_review[index]['customer_name']}",
                                                            ),
                                                            Text(
                                                              "${_controller.shop_info.all_review[index]['created_at']}",
                                                              style: Themes
                                                                  .subtitle2,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: _controller.shop_info.all_review[index]['value'] >= 1
                                                                      ? Colors.yellow.shade700
                                                                      : Themes.color,
                                                                  size: 16,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: _controller.shop_info.all_review[index]['value'] >= 2
                                                                      ? Colors.yellow.shade700
                                                                      : Themes.color,
                                                                  size: 16,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: _controller.shop_info.all_review[index]['value'] >= 3
                                                                      ? Colors.yellow.shade700
                                                                      : Themes.color,
                                                                  size: 16,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: _controller.shop_info.all_review[index]['value'] >= 4
                                                                      ? Colors.yellow.shade700
                                                                      : Themes.color,
                                                                  size: 16,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: _controller.shop_info.all_review[index]['value'] >= 5
                                                                      ? Colors.yellow.shade700
                                                                      : Themes.color,
                                                                  size: 16,
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        leading: CircleAvatar(
                                                          radius: 40,
                                                          backgroundImage:
                                                          AssetImage(
                                                              'images/shop2.jpg'),
                                                          backgroundColor:
                                                          Colors.grey,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width -
                                                            50,
                                                        child: Card(
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20.0),
                                                            side: BorderSide(
                                                              color:
                                                              Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(
                                                                20.0),
                                                            child: _controller.shop_info.all_review[index]['notes']!=null ? Text(
                                                              "${_controller.shop_info.all_review[index]['notes']}",
                                                            ) : Text("لا يوجد تعليق"),
                                                          ),
                                                          margin:
                                                          EdgeInsets.all(
                                                              10),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                );
                                              }),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          controller.shop_info.all_review.length < 4 || controller.size_list == controller.shop_info.all_review.length  ?  SizedBox.shrink() : Center(
                                              child: InkWell(
                                                  onTap: () {
                                                    controller.increment_size();
                                                  },
                                                  child: Text("عرض المزيد"))
                                          ) ,
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      );
                                    },)

                                ) : Center(
                                  child:  Column(
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.25,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage('images/1.png'),
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                                      Text("لا يوجد تقييمات" , )
                                    ],
                                  ),
                                ),
                              )
                                  : _controller.products_classification.length == 0 ? Center(
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
                                    Text("لا يوجد منتجات متاحة" , )
                                  ],
                                ) ,
                              ) : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    hint: const Padding(
                                      padding: EdgeInsets.only(right: 16.0),
                                      child: Text(
                                        "اختر التصنيف",
                                        style: Themes.bodyText1,
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10, 0.001, 12, 0.001),
                                        filled: true,
                                        fillColor: Colors.white),
                                    onChanged: (newValue) {
                                      controller
                                          .setselectedSection(newValue);
                                    },
                                    validator: (val) {
                                      return null;
                                    },
                                    items: controller.items.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          item,
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                        ),
                                        value: item,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              !controller.check_tap.value
                                  ?SizedBox.shrink()
                                  :ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _controller.products_classification.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {

                                    return Center(
                                      child: Column(
                                        children: [
                                          InkWell(
                                            child: Text("${_controller.products_classification[_controller.products_classification.keys.elementAt(index)]!.elementAt(0).classifications_title}",
                                                style: Themes.headline3),
                                            onTap: () {
                                              Get.to(Seggestions(
                                                  title: "${_controller.products_classification[_controller.products_classification.keys.elementAt(index)]!.elementAt(0).classifications_title}" , products: controller.products_classification[controller.products_classification.keys.elementAt(index)]!));

                                            },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GridView.builder(
                                            physics:
                                            NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                            ),
                                            itemCount:_controller.products_classification[_controller.products_classification.keys.elementAt(index)]!.length>4? 4 : _controller.products_classification[_controller.products_classification.keys.elementAt(index)]!.length,
                                            itemBuilder: (context, ind) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.5,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.6,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      bottom: 10.0),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      InkWell(
                                                        child: Container(
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10),
                                                            image: DecorationImage(
                                                              image: NetworkImage('${MyApp.api}/uploads/product/${controller.products_classification[controller.products_classification.keys.elementAt(index)]!.elementAt(ind).image}' ),
                                                            ),
                                                          ),

                                                          height: MediaQuery.of(context).size.height * 0.25,
                                                        ),
                                                        onTap: () {
                                                          Get.to(
                                                              ProductDeatil(_controller.products_classification[controller.products_classification.keys.elementAt(index)]!.elementAt(ind).id));
                                                        },
                                                      ),
                                                      GetBuilder<ShopProfileController>(builder:(ShopProfileController controller2) {
                                                        return  Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 8.0 , top: 20),
                                                            child: InkWell(
                                                              onTap: () {
                                                                /////Action
                                                                _controller.addToFavouriteProduct(_controller.products_classification.keys.elementAt(index), _controller.products_classification[_controller.products_classification.keys.elementAt(index)]!.elementAt(ind).id, ind) ;
                                                              },
                                                              child:
                                                              CircleAvatar(
                                                                child: Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: controller2.products_classification[controller2.products_classification.keys.elementAt(index)]!.elementAt(ind).isFavourite ? Colors
                                                                      .red : Colors.grey,
                                                                  size: 16,
                                                                ),
                                                                backgroundColor: Colors.grey.shade300,
                                                                radius: 14,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                      Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${controller.products_classification[controller.products_classification.keys.elementAt(index)]!.elementAt(ind).selling_price}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize: 12),

                                                              ), Text(" ل.س" ,style: TextStyle(
                                                                  color: Colors.red,
                                                                  fontSize: 12))
                                                            ],mainAxisAlignment: MainAxisAlignment.end,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          InkWell(
                                              child: Text("عرض المزيد",
                                                  style: TextStyle(
                                                    color:
                                                    Colors.grey.shade600,
                                                  )),
                                              onTap: () {
                                                Get.to(Seggestions(
                                                    title: "${_controller.products_classification[_controller.products_classification.keys.elementAt(index)]!.elementAt(0).classifications_title}" , products: controller.products_classification[controller.products_classification.keys.elementAt(index)]!));
                                              }),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: Divider(),
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  );
                });
              }),
              )
          ),
        ));
  }
}

class HeaderCurvedContainer extends CustomPainter {
  final color = const Color(0xFFAF3A88);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = ui.Gradient.linear(
          const Offset(10, 100), const Offset(450, 100), [color, color]);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 3, 250, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
