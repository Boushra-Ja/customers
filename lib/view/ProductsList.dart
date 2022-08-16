import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../utls/Themes.dart';
import 'ProductDeatil.dart';

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Get.to(ProductDeatil(1));
            },
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15.0, right: 10, left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0.2,
                              offset: Offset(1, 1),
                              color: Colors.grey),
                        ]),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/shop2.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "اسم المنتج",
                              style: Themes.headline3,
                              maxLines: 2,
                            ),
                            const Text("السعر 2000 ل.س",
                                style: Themes.subtitle1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.tag_faces_outlined,
                                  color: Themes.color,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "(20 تقييم)",
                                  style: Themes.subtitle2,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                //const Divider()
              ],
            ),
          );
        });
  }
}
