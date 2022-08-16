import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../logic/controllers/products/ProductDeatilController.dart';
import '../logic/controllers/products/RatingProductController.dart';
import '../main.dart';
import '../models/Boshra/products/Option.dart';
import '../utls/Themes.dart';
import 'EvaluationDialoge.dart';
import 'Seggestions.dart';
import 'ShopsPages/ShopProfile.dart';

class ProductDeatil extends GetView<ProductDeatilController> {
  var id;

  ProductDeatil(this.id);

  @override
  Widget build(BuildContext context) {
    ProductDeatilController controller = Get.put(ProductDeatilController(id));
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                      ()async {
                    controller.user_id  =  await controller.storage.read(key: 'id') ;
                    await controller.fetchProductInfo(id) ;
                  },
                );
              }, child:Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                '${MyApp.api}/uploads/product/${controller
                                    .product.image}'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          right: 15,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: Themes.color,
                              ),
                              backgroundColor: Themes.color2,
                            ),
                          )),
                      GetBuilder<RatingProductController>(
                        init: RatingProductController(id),
                        builder: (RatingProductController controller_) {
                          return Positioned(
                            right: 70,
                            child: InkWell(
                              onTap: () {
                                if (!controller.product.isRating) {
                                  Get.defaultDialog(
                                    radius: 20,
                                    title: "ما هو تقييمك لهذا المنتج؟؟",
                                    titlePadding: EdgeInsets.only(top: 20),
                                    backgroundColor: Colors.white,
                                    titleStyle: Themes.headline1,
                                    content: EvaluationDialoge(id),
                                    barrierDismissible: false,

                                  );
                                  if (controller_.isRate)
                                    controller.product.isRating = true;
                                }
                              },
                              child: CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  Icons.star_rate,
                                  color: Themes.color,
                                ),
                                backgroundColor: Themes.color2,
                              ),
                            ),
                          );
                        },)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Align(
                          child: Row(
                            children: [
                              Text(
                                "${controller.product.selling_price}",
                                style: Themes.subtitle2,
                              ),
                              Text(" ل.س")
                            ],
                          ),
                          alignment: AlignmentDirectional.topEnd,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(ShopProfile(controller.product.store_id));
                        },
                        child: const Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('images/shop2.jpg'),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(ShopProfile(controller.product.store_id));
                            },
                            child: Text(
                              "${controller.product.store_name}",
                              style: Themes.bodyText1,
                              maxLines: 2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("عدد المبيعات", style: Themes.subtitle2),
                              Text(" ${controller.product.salling_store}",
                                  style: Themes.subtitle2)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.35,
                      ),
                      GetBuilder<ProductDeatilController>(
                          builder: (ProductDeatilController controller2) {
                            return InkWell(

                              onTap: () {
                                controller2.addToFavouriteProduct(id, -1);
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Themes.color2,
                                child: Icon(
                                  Icons.favorite,
                                  color: controller2.product.isFavourite
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 20,
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        width: 7,
                      ),


                    ],
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${controller.product.product_name}",
                          style: Themes.headline5,),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("لمحة عن المنتج : "),
                            Flexible(
                              child: Text(
                                "${controller.product.discription}",
                                style: Themes.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  Divider(),
                  controller.product.is_basket ? SizedBox.shrink() : ListView
                      .builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.product.options.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 20.0, bottom: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${controller.product.options.keys
                                        .elementAt(index)}",
                                    style: Themes.bodyText1,
                                  )),
                              Expanded(
                                flex: 3,
                                child: Container(
                                    height: 35,
                                    child: GetBuilder<ProductDeatilController>(
                                      init: ProductDeatilController(id),
                                      builder:
                                          (ProductDeatilController controller) {
                                        return DropdownButtonFormField(
                                          isDense: true,
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          hint: Text("اختر"),
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
                                                (newValue as Option).value_id);
                                            controller.count++;
                                          },
                                          validator: (val) {
                                            return controller
                                                .validate_value(val.toString());
                                          },
                                          items: controller.product.options[
                                          '${controller.product.options.keys
                                              .elementAt(index)}']
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
                          flex: 6,
                          child: GetBuilder<ProductDeatilController>(
                            init: ProductDeatilController(id),
                            builder: (ProductDeatilController controller2) {
                              return Container(
                                margin: EdgeInsets.only(left: 5),
                                height: 40,
                                child: ElevatedButton(

                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey.shade50,
                                    shape:
                                    RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.grey.shade200),
                                        borderRadius: BorderRadius.circular(
                                            10)),


                                  ),
                                  onPressed: () {
                                    controller2.product.is_basket ? controller2
                                        .deleteFromBasket() : controller2
                                        .addTo_Basket();
                                  },

                                  child: controller2.product.is_basket ? Text(
                                    'حذف من السلة', style: Themes.subtitle1,
                                  ) : Text('إضافة إلى السلة',
                                    style: Themes.subtitle1,),
                                ),
                              );
                            },)

                      ),
                      Expanded(
                          flex: 2,
                          child: GetBuilder<ProductDeatilController>(
                            builder: (ProductDeatilController controller2) {
                              return Container(
                                height: 40,
                                margin: EdgeInsets.only(left: 5),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey.shade50,
                                      shape:
                                      RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.grey.shade200),
                                          borderRadius: BorderRadius.circular(
                                              10)),

                                    ),
                                    onPressed: () {


                                      controller2.product.is_basket ? controller2.deleteFromBasket() : controller2.addTo_Basket();


                                    },

                                    child: Icon(Icons.shopping_cart_outlined,
                                      color: Themes.borderColor,)),
                              );
                            },)),
                      Expanded(
                          flex: 2,
                          child: Container(
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey.shade50,
                                  shape:
                                  RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.grey.shade200),
                                      borderRadius: BorderRadius.circular(10)),


                                ),
                                onPressed: () {},


                                child: Icon(Icons.send,
                                  color: Themes.borderColor,)),
                          )),
                      Expanded(
                        child: SizedBox.shrink(),
                        flex: 1,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, right: 20.0, left: 20.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "الوقت المتوقع للتسليم بدءا من قبول الطلب  ${controller
                                .product.prepration_time}",
                            style: Themes.subtitle2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, right: 20.0, left: 20.0),
                    child: controller.product.return_or_replace == 100
                        ? Text(
                      " يمكن تبديل المنتج فقط وذلك خلال 24 ساعة من وقت الاستلام وذلك عبر الاتصال على الرقم 098877778 مع توضيح ذكر التبديل",
                      style: Themes.subtitle2,
                    )
                        : Text(
                      "لا يوجد تبديل أو إرجاع للمنتج",
                      style: Themes.subtitle2,
                    ),
                  ),
                  SizedBox(height: 20,),
                  controller.product.similar_product.length != 0
                      ? Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, left: 20, right: 20),
                    child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(Seggestions(
                              title: "منتجات مشابهة",
                              products: controller.product.similar_product,));
                          },
                          child: Text(
                            "منتجات مشابهة",
                            style: Themes.headline2,
                          ),
                        )),
                  )
                      : SizedBox.shrink(),
                  controller.product.similar_product.length != 0
                      ? Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.35,
                    width: double.infinity,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                        controller.product.similar_product.length > 5
                            ? 5
                            : controller.product.similar_product.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Stack(
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.5,
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.25,
                                    child: Image.network(
                                        '${MyApp
                                            .api}/uploads/product/${controller
                                            .product.similar_product
                                            .elementAt(index)
                                            .image}'),
                                  ),
                                  onTap: () async {
                                    print(controller.product
                                        .similar_product[index].id) ;
                                    Get.to(ProductDeatil(controller.product
                                        .similar_product[index].id));
                                    controller.isLoading.value = true;
                                    controller.fetchProductInfo(
                                        controller.product
                                            .similar_product[index].id);
                                  },
                                ),
                                GetBuilder<ProductDeatilController>(builder: (
                                    ProductDeatilController controller2) {
                                  return Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          right: 10.0, top: 10),
                                      child: InkWell(
                                        onTap: () {
                                          /////Action
                                          controller2.addToFavouriteProduct(
                                              controller2.product
                                                  .similar_product[index].id,
                                              index);
                                        },
                                        child: CircleAvatar(
                                          child: Icon(
                                            Icons.favorite,
                                            color: controller2.product
                                                .similar_product
                                                .elementAt(index)
                                                .isFavourite
                                                ? Colors.red
                                                : Colors.grey,
                                            size: 16,
                                          ),
                                          backgroundColor: Colors.grey.shade300,
                                          radius: 14,
                                        ),
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                          );
                        }),
                  )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery
                            .of(context)
                            .size
                            .width * 0.2),
                    child: Divider(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
                    child: Center(
                        child: Text(
                          "تقييمات المنتج",
                          style: Themes.headline2,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: controller.product.all_review.length == 0
                        ? Center(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.25,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/1.png'),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          Text("لا يوجد تقييمات",)
                        ],
                      ),
                    )
                        : Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            ListView.builder(
                                itemCount: controller.product.all_review
                                    .length >= 4
                                    ? controller.size_list.value
                                    : controller.product.all_review.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ListTile(
                                          title: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${controller.product
                                                      .all_review[index]['customer_name']}"),
                                              Text(
                                                "${controller.product
                                                    .all_review[index]['created_at']}",
                                                style: Themes.subtitle2,
                                              ),
                                            ],
                                          ),
                                          leading: CircleAvatar(
                                            radius: 50,
                                            backgroundImage: AssetImage(
                                                'images/shop2.jpg'),
                                            backgroundColor: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width -
                                              50,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                              side: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  20.0),
                                              child: controller.product
                                                  .all_review[index]['notes'] !=
                                                  null
                                                  ? Text(
                                                  "${controller.product
                                                      .all_review[index]['notes']}")
                                                  : Text("لا يوجد تعليق"),
                                            ),
                                            margin: EdgeInsets.all(10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            controller.product.all_review.length < 4 ||
                                controller.size_list == controller.product
                                    .all_review.length
                                ? SizedBox.shrink()
                                : Center(
                              child: InkWell(
                                  onTap: () {
                                    controller.increment_size();
                                  },
                                  child: Text("عرض المزيد")),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )

                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              );
            }),)
        ));
  }
}

/*
    // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return StatefulBuilder(
                          //         builder: (context, setState) {
                          //           return AlertDialog(
                          //             title:Center(child: Text( "ما هو تقييمك للمتجر الفلاني؟" , style: Themes.headline1,)),
                          //                 titlePadding: EdgeInsets.only(top: 20),
                          //                 backgroundColor: Colors.white,
                          //
                          //
                          //             content: SingleChildScrollView(
                          //               child: Container(
                          //                 height: MediaQuery.of(context).size.height * 0.75,
                          //                 width: MediaQuery.of(context).size.width * 0.9,
                          //                 child: EvaluationDialoge(),
                          //               ),
                          //             ),
                          //             actions: [
                          //           Padding(
                          //               padding: const EdgeInsets.only(right: 30.0),
                          //               child: RaisedButton(
                          //                 color: Themes.color,
                          //                     onPressed: () {
                          //                   Get.back();
                          //                     },
                          //                     child : Text('تخطي' , style: TextStyle(color: Colors.white))
                          //                 ),
                          //             ),
                          //              Padding(
                          //                 padding: const EdgeInsets.only(left :30.0),
                          //           child: RaisedButton(
                          //           color: Themes.color,
                          //
                          //           onPressed: () {  },
                          //           child : Text('تقييم' , style: TextStyle(color: Colors.white))
                          //           ),
                          //              )
                          //               // FlatButton(
                          //               //   child: Text("Annuler"),
                          //               //   onPressed: () {
                          //               //     Navigator.of(context)
                          //               //         .pop(); // dismiss dialog
                          //               //   },
                          //               // ),
                          //             ],
                          //           );
                          //         },
                          //       );
                          //     });
 */

// Get.defaultDialog(
//     title: "ما هو تقييمك للمتجر الفلاني؟",
//     titlePadding: EdgeInsets.only(top: 20),
//     backgroundColor: Colors.white,
//     titleStyle: Themes.headline1,
//
//     content :
//
//
//     EvaluationDialoge(),
//   cancel:Padding(
//     padding: const EdgeInsets.only(right: 30.0),
//     child: RaisedButton(
//       color: Themes.color,
//           onPressed: () {
//         Get.back();
//           },
//           child : Text('تخطي' , style: TextStyle(color: Colors.white))
//       ),
//   ),
//
//   confirm: Padding(
//     padding: const EdgeInsets.only(left :30.0),
//     child: RaisedButton(
//         color: Themes.color,
//
//         onPressed: () {  },
//           child : Text('تقييم' , style: TextStyle(color: Colors.white))
//       ),
//   ),
//   barrierDismissible: false,
// );

/*
                    Positioned(
                        right: 70,
                        child: InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              title: "الإبلاغ عن المنتج",
                              titlePadding: EdgeInsets.only(top: 20),
                              backgroundColor: Colors.white,
                              titleStyle: Themes.headline1,
                              radius: 15,
                              content: Builder(
                                builder: (context) {
                                  return Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 8),
                                          child: GetBuilder<
                                              ProductDeatilController>(
                                            init: ProductDeatilController(id),
                                            builder: (controller) {
                                              return TextField(
                                                onChanged: (newValue) {
                                                  controller
                                                      .set_reportofproduct(
                                                          newValue);
                                                },
                                                keyboardType:
                                                    TextInputType.text,
                                                maxLines: 4,
                                                decoration: InputDecoration(
                                                    label: Padding(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Center(
                                                        child: Text(
                                                          'سبب الشكوى',
                                                          style:
                                                              Themes.subtitle1,
                                                        ),
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Themes.color,
                                                            width: 4.0))),
                                              );
                                            },
                                          )),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          'إرسال',
                                          style: TextStyle(
                                              color: Themes.color2,
                                              fontSize: 16.0),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Themes.color,
                                          onPrimary: Themes.color,
                                          shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.report,
                              color: Themes.color,
                            ),
                            backgroundColor: Themes.color2,
                          ),
                        ))

 */