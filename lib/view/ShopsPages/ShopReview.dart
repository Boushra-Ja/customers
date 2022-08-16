import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controllers/ShopsController/RatingProfileController.dart';
import '../../main.dart';
import '../../utls/Themes.dart';

class ShopReview extends StatelessWidget {

  final store_id ;
  ShopReview(this.store_id) ;

  @override
  Widget build(BuildContext context) {
    RatingProfileController controller = Get.put(RatingProfileController(store_id)) ;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Obx(
              (){
                return controller.isLoading.value ? Container(
                  height: double.infinity,
                  child: ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.35 -
                                  MediaQuery.of(context).size.height * 0.15,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Themes.color,
                                  image: DecorationImage(
                                      image:  NetworkImage(
                                          '${MyApp.api}/uploads/stores/${controller.info.brand}' ),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.06,
                              right: MediaQuery.of(context).size.width * 0.5 - 80,
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10, top: 10),
                                      child: CircleAvatar(
                                        radius: 70,
                                        backgroundImage:
                                        NetworkImage(
                                            '${MyApp.api}/uploads/stores/${controller.info.image}'),
                                      ),
                                    ),
                                    Text(
                                      "${controller.info.shop_name}",
                                      style: Themes.headline1,
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: controller.
                                              info
                                              .review >=
                                              1
                                              ? Colors
                                              .yellow
                                              .shade700
                                              : Themes
                                              .color,
                                          size: 18,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: controller.
                                          info
                                              .review >=
                                              2
                                              ? Colors
                                              .yellow
                                              .shade700
                                              : Themes
                                              .color,
                                          size: 18,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color:controller.
                                          info
                                              .review >=
                                              3
                                              ? Colors
                                              .yellow
                                              .shade700
                                              : Themes
                                              .color,
                                          size: 18,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: controller.
                                          info
                                              .review >=
                                              4
                                              ? Colors
                                              .yellow
                                              .shade700
                                              : Themes
                                              .color,
                                          size: 18,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color:controller.
                                          info
                                              .review ==
                                              5
                                              ? Colors
                                              .yellow
                                              .shade700
                                              : Themes
                                              .color,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(bottom: 15.0, right: 10, left: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 0.7,
                                    offset: Offset(1, 1),
                                    color: Colors.grey),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "خلال الشهر السابق",
                                    style: Themes.headline1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "عدد المبيعات ${controller.info.num_sales_last_month}",
                                  style: Themes.headline2,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.sentiment_very_satisfied_outlined,
                                          size: 40,
                                          color: Colors.green,

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${controller.info.good_last_month}",
                                          style: Themes.subtitle1,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.sentiment_satisfied,
                                          size: 40,
                                          color: Colors.orange,

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${controller.info.smile_last_month}",
                                          style: Themes.subtitle1,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.mood_bad,
                                          size: 40,
                                          color: Colors.red,

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${controller.info.bad_last_month}",
                                          style: Themes.subtitle1,
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(bottom: 15.0, right: 10, left: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 0.7,
                                    offset: Offset(1, 1),
                                    color: Colors.grey),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "خلال الشهرين السابقين",
                                    style: Themes.headline1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "عدد المبيعات ${controller.info.num_sales_befor_2month}",
                                  style: Themes.headline2,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.sentiment_very_satisfied_outlined,
                                          size: 40,
                                          color: Colors.green,

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${controller.info.good_last_2month}",
                                          style: Themes.subtitle1,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.sentiment_satisfied,
                                          size: 40,
                                          color: Colors.orange,

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${controller.info.smile_last_2month}",
                                          style: Themes.subtitle1,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.mood_bad,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${controller.info.bad_last_2month}",
                                          style: Themes.subtitle1,
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(bottom: 15.0, right: 10, left: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 0.7,
                                    offset: Offset(1, 1),
                                    color: Colors.grey),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "خلال الأشهر الثلاثة السابقة",
                                    style: Themes.headline1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "عدد المبيعات ${controller.info.num_sales_befor_3month}",
                                  style: Themes.headline2,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.sentiment_very_satisfied_outlined,
                                          size: 40,
                                          color: Colors.green,

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${controller.info.good_last_3month}",
                                          style: Themes.subtitle1,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.sentiment_satisfied,
                                          size: 40,
                                          color: Colors.orange,

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${controller.info.smile_last_3month}",
                                          style: Themes.subtitle1,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.mood_bad,
                                          size: 40,
                                          color: Colors.red,

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${controller.info.bad_last_3month}",
                                          style: Themes.subtitle1,
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ) : Center(child: CircularProgressIndicator(),);
              }
          )
        ));
  }
}
