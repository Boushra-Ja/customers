import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../logic/controllers/AppBarController.dart';
import '../logic/controllers/DrawerController/SettingPageController.dart';
import '../logic/controllers/products/ProductController.dart';
import '../main.dart';
import '../models/batool/FavoriteProduct2Model.dart';
import '../services/auth_services.dart';
import '../utls/Themes.dart';
import 'ConstantPages/Drawer.dart';
import 'ProductDeatil.dart';
import 'Seggestions.dart';

class Product extends GetView<ProductController> {
  final sampleController2 = Get.find<ProductController>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<SettingPageController>(
          init: SettingPageController(),
            builder: (sampleController3) => GetBuilder<AppBarController>(
                init: AppBarController(),
                builder: (sampleController1) {
                  return Scaffold(
                      backgroundColor: sampleController3.col == 0
                          ? Colors.white
                          : Colors.black,
                      key: sampleController1.getscaffoldKey2(),
                      drawer: myDrawer(),
                      body: GetBuilder<ProductController>(builder: (controller) {
                        return Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 48.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    onPressed: () {
                                      sampleController1
                                          .getscaffoldKey2()
                                          .currentState!
                                          .openDrawer();
                                    },
                                    icon: Icon(
                                      Icons.menu,
                                      size: 35,
                                      color: Themes.color3,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Themes.color3,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(children: [
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          print("search");
                                        },
                                        icon: Icon(
                                          Icons.search,
                                          color: Themes.color3,
                                        ),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Form(
                                        key: controller.formstate,
                                        child: TextFormField(
                                          cursorColor: Colors.grey,
                                          autofocus: false,
                                          enableInteractiveSelection: false,
                                          onChanged: (val) {
                                            var formdata = controller
                                                .formstate.currentState;
                                            if (formdata!.validate())
                                              formdata.save();

                                            controller.search_products(1);
                                            controller.search_products(2);
                                            controller.search_products(4);
                                          },
                                          decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 5),
                                              hintText: "انقر هنا للبحث...."),
                                          keyboardType: TextInputType.text,
                                          validator: (val) {},
                                          onSaved: (val) {
                                            if (val == "") val = " ";
                                            controller.search_name = val!;
                                          },
                                          initialValue: "",
                                          style: Themes.subtitle2,
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed('/Cart');
                                    },
                                    icon: Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 30,
                                      color: Themes.color3,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    controller.listpoduct_classification.length,
                                itemBuilder: (context, index) {
                                  var i = 0;
                                  i++;
                                  return Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 20),
                                      margin: EdgeInsets.only(
                                          top: 10,
                                          bottom: 45,
                                          left: 10,
                                          right: 5),
                                      child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              //background color of dropdown button
                                              border: Border.all(
                                                color:
                                                    sampleController3.col == 0
                                                        ? Themes.color
                                                        : Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              //border raiuds of dropdown button
                                              boxShadow: <BoxShadow>[
                                                //apply shadow on Dropdown button
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.57),
                                                    blurRadius: 2)
                                              ]),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 30, right: 30),
                                            child: Obx(() =>
                                                DropdownButton<String>(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    isExpanded: false,
                                                    style: Themes.subtitle2,
                                                    alignment: Alignment.center,
                                                    dropdownColor:
                                                        sampleController3.col ==
                                                                0
                                                            ? Colors.white
                                                            : Colors.white,
                                                    hint: Text(
                                                      "${controller.listpoduct_classification.elementAt(index).title}",
                                                      style: Themes.bodyText1,
                                                    ),
                                                    value: controller.selectedValue.elementAt(index + i),
                                                    onChanged: (newValue) {
                                                      controller.onSelected(newValue!, controller.listpoduct_classification.elementAt(index).id);
                                                      controller.DropDown(1, newValue);
                                                      controller.DropDown(2, newValue);
                                                      controller.DropDown(4, newValue);
                                                    },
                                                    elevation: 10,
                                                    items: [
                                                      for (var data in controller.listpoduct_classification.elementAt(index).mySecondary)
                                                        DropdownMenuItem(
                                                          child: Text("${data.title}",),
                                                          value: "${data.title}",
                                                        )
                                                    ])),
                                          )));
                                }),
                          ),
                          sampleController2.listpoduct_salary.isEmpty &&
                              sampleController2.listpoduct_sales.isEmpty &&
                              sampleController2.listpoduct_favorite.isEmpty &&
                              sampleController2.listpoduct_discount.isEmpty ?
                            Expanded(flex:4,
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
                              ),
                            ) :
                          Obx(() {
                            if (sampleController2.isLoading.value) {
                              return Center(
                                child: CircularProgressIndicator().reactive(),
                              );
                            }
                            return Expanded(
                                flex: 4,
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    //////////////////////////////////listpoduct_discount
                                    sampleController2
                                            .listpoduct_discount.isEmpty
                                        ? SizedBox.shrink()
                                        : Column(
                                            children: [
                                              Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.5,
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: controller
                                                          .listpoduct_discount
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var item = controller
                                                            .listpoduct_discount;
                                                        return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              index == 0
                                                                  ? Row(
                                                                      children: [
                                                                        InkWell(
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 20, bottom: 10),
                                                                            child:
                                                                                Text("عروض وحسومات", style: Themes.headline1),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            Get.to(Seggestions(
                                                                              title: "عروض وحسومات",
                                                                              products: [],
                                                                            ));
                                                                          },
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              right: 8,
                                                                              bottom: 8),
                                                                          child: IconButton(
                                                                              onPressed: () {
                                                                                Get.to(Seggestions(
                                                                                  title: "عروض وحسومات",
                                                                                  products: controller.listpoduct_discount,
                                                                                ));
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.arrow_forward,
                                                                                color: sampleController3.col == 1 ? Colors.white : Themes.color3,
                                                                                size: 25,
                                                                              )),
                                                                        )
                                                                      ],
                                                                    )
                                                                  : Row(
                                                                      children: [
                                                                        InkWell(
                                                                          child: Container(
                                                                              margin: EdgeInsets.only(right: 28, bottom: 40),
                                                                              child: Text("    ")),
                                                                        ),
                                                                      ],
                                                                    ),
                                                              Column(children: [
                                                                SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Column(
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Stack(
                                                                                    children: [
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          Get.to(ProductDeatil(controller.listpoduct_discount.elementAt(index).id));
                                                                                        },
                                                                                        child: Container(
                                                                                          margin: EdgeInsets.only(right: 10),
                                                                                          width: MediaQuery.of(context).size.width * 0.75,
                                                                                          height: MediaQuery.of(context).size.height * 0.3,
                                                                                          child: ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(20),
                                                                                            child: Image.network(
                                                                                              "${MyApp.api}/uploads/product/${item.elementAt(index).image}",
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Positioned(
                                                                                        left: 10,
                                                                                        top: 15,
                                                                                        child: InkWell(
                                                                                          onTap: () async {
                                                                                            var data = await AuthServices.doo(product_id: controller.listpoduct_discount.elementAt(index).id);
                                                                                            if (data == "add") {
                                                                                              Favorite_product2 g = new Favorite_product2(product_id: controller.listpoduct_discount.elementAt(index).id, id: 9);
                                                                                              controller.listpoduct_f.add(g);

                                                                                              controller.listpoduct_discount.elementAt(index).isFavourite = true;
                                                                                              controller.changeCol(data, 1, controller.listpoduct_discount.elementAt(index).id);
                                                                                            } else {
                                                                                              controller.listpoduct_discount.elementAt(index).isFavourite = false;

                                                                                              for (int i = 0; i < controller.listpoduct_f.length; i++) {
                                                                                                if (controller.listpoduct_discount.elementAt(index).id == controller.listpoduct_f.elementAt(i).product_id) controller.listpoduct_f.removeAt(i);
                                                                                              }

                                                                                              controller.changeCol(data, 2, controller.listpoduct_discount.elementAt(index).id);
                                                                                            }
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            backgroundColor: Themes.color2,
                                                                                            child: Icon(
                                                                                              Icons.favorite,
                                                                                              color: controller.check(controller.listpoduct_discount.elementAt(index).id) ? Colors.red : Colors.black,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Row(children: [
                                                                                    Container(
                                                                                      margin: EdgeInsets.only(right: 20),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text("${controller.listpoduct_discount.elementAt(index).product_name} ", style: Themes.bodyText1),
                                                                                          SizedBox(
                                                                                            width: 5,
                                                                                          ),
                                                                                          Icon(
                                                                                            controller.listpoduct_discount[index].rating == 0
                                                                                                ? Icons.mood_bad
                                                                                                : controller.listpoduct_discount[index].rating == 1
                                                                                                    ? Icons.sentiment_satisfied
                                                                                                    : Icons.sentiment_very_satisfied_outlined,
                                                                                            color: controller.listpoduct_discount[index].rating == 0
                                                                                                ? Colors.red
                                                                                                : controller.listpoduct_discount[index].rating == 1
                                                                                                    ? Colors.orange
                                                                                                    : Colors.green,

//  sampleController3.col==1?Colors.white: Colors.green,
                                                                                          ),
                                                                                          Container(
                                                                                              margin: EdgeInsets.only(
                                                                                                right: MediaQuery.of(context).size.width * 0.2,
                                                                                              ),
                                                                                              child: Text("${controller.listpoduct_discount.elementAt(index).selling_price}" + " ل.س ", style: TextStyle(color: Colors.red, fontSize: 12))),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ]),
                                                                                ],
                                                                              ),
                                                                            ]),
                                                                        SizedBox(
                                                                          width:
                                                                              25,
                                                                        ),
                                                                      ]),
                                                                ),
                                                              ]),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                            ]);
                                                      })
//////////////////////////////////////////////////////////////////////////////////////////
                                                  ),
                                              Row(children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 150,
                                                        top: 1,
                                                        bottom: 10),
                                                    child: TextButton(
                                                      child: Text("عرض المزيد",
                                                          style:
                                                              Themes.subtitle2),
                                                      onPressed: () {
                                                        Get.to(Seggestions(
                                                          title: "عروض وحسومات",
                                                          products: controller
                                                              .listpoduct_discount,
                                                        ));
                                                      },
                                                    ))
                                              ]),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 80, left: 80),
                                                child: Divider(),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),

//////////////////////////////////listpoduct_favorite
                                    sampleController2
                                            .listpoduct_favorite.isEmpty
                                        ? SizedBox.shrink()
                                        : Column(children: [
                                            Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: controller
                                                        .listpoduct_favorite
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var item = controller
                                                          .listpoduct_favorite;
                                                      return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            index == 0
                                                                ? Row(
                                                                    children: [
                                                                      InkWell(
                                                                        child:
                                                                            Container(
                                                                          margin: EdgeInsets.only(
                                                                              right: 28,
                                                                              bottom: 10),
                                                                          child: Text(
                                                                              "اقتراحات قد تعجبك",
                                                                              style: Themes.headline1),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          Get.to(
                                                                              Seggestions(
                                                                            title:
                                                                                "اقتراحات قد تعجبك",
                                                                            products:
                                                                                controller.listpoduct_favorite,
                                                                          ));
                                                                        },
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                8,
                                                                            bottom:
                                                                                8),
                                                                        child: IconButton(
                                                                            onPressed: () {
                                                                              Get.to(Seggestions(
                                                                                title: "اقتراحات قد تعجبك ",
                                                                                products: controller.listpoduct_favorite,
                                                                              ));
                                                                            },
                                                                            icon: Icon(
                                                                              Icons.arrow_forward,
                                                                              color: sampleController3.col == 1 ? Colors.white : Themes.color3,
                                                                              size: 25,
                                                                            )),
                                                                      )
                                                                    ],
                                                                  )
                                                                : Row(
                                                                    children: [
                                                                      InkWell(
                                                                        child: Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 28, bottom: 40),
                                                                            child: Text(" ")),
                                                                      ),
                                                                    ],
                                                                  ),
                                                            Column(children: [
                                                              SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Column(
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Stack(
                                                                                  children: [
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        Get.to(ProductDeatil(controller.listpoduct_favorite.elementAt(index).id));
                                                                                      },
                                                                                      child: Container(
                                                                                        margin: EdgeInsets.only(right: 10),
                                                                                        width: MediaQuery.of(context).size.width * 0.75,
                                                                                        height: MediaQuery.of(context).size.height * 0.3,
                                                                                        child: ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(20),
                                                                                            child: Image.network(
                                                                                              "${MyApp.api}/uploads/product/${item.elementAt(index).image}",
                                                                                              fit: BoxFit.cover,
                                                                                            )),
                                                                                      ),
                                                                                    ),
                                                                                    Positioned(
                                                                                      left: 10,
                                                                                      top: 15,
                                                                                      child: InkWell(
                                                                                        onTap: () async {
                                                                                          var data = await AuthServices.doo(product_id: controller.listpoduct_favorite.elementAt(index).id);
                                                                                          if (data == "add") {
                                                                                            Favorite_product2 g = new Favorite_product2(product_id: controller.listpoduct_favorite.elementAt(index).id, id: 9);
                                                                                            controller.listpoduct_f.add(g);
                                                                                            controller.listpoduct_favorite.elementAt(index).isFavourite = true;
                                                                                            controller.changeCol(data, 1, controller.listpoduct_favorite.elementAt(index).id);
                                                                                          } else {
                                                                                            controller.listpoduct_favorite.elementAt(index).isFavourite = false;

                                                                                            for (int i = 0; i < controller.listpoduct_f.length; i++) {
                                                                                              if (controller.listpoduct_favorite.elementAt(index).id == controller.listpoduct_f.elementAt(i).product_id) controller.listpoduct_f.removeAt(i);
                                                                                            }

                                                                                            controller.changeCol(data, 2, controller.listpoduct_favorite.elementAt(index).id);
                                                                                          }
                                                                                        },
                                                                                        child: CircleAvatar(
                                                                                          backgroundColor: Themes.color2,
                                                                                          child: Icon(
                                                                                            Icons.favorite,
                                                                                            color: controller.check(controller.listpoduct_favorite.elementAt(index).id) ? Colors.red : Colors.black,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                Row(children: [
                                                                                  Container(
                                                                                    margin: EdgeInsets.only(right: 20),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Text("${controller.listpoduct_favorite.elementAt(index).product_name} ", style: Themes.bodyText1),
                                                                                        SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        Icon(
                                                                                          controller.listpoduct_favorite[index].rating == 0
                                                                                              ? Icons.mood_bad
                                                                                              : controller.listpoduct_favorite[index].rating == 1
                                                                                                  ? Icons.sentiment_satisfied
                                                                                                  : Icons.sentiment_very_satisfied_outlined,
                                                                                          color: controller.listpoduct_favorite[index].rating == 0
                                                                                              ? Colors.red
                                                                                              : controller.listpoduct_favorite[index].rating == 1
                                                                                                  ? Colors.orange
                                                                                                  : Colors.green,

//  sampleController3.col==1?Colors.white: Colors.green,
                                                                                        ),
                                                                                        Container(
                                                                                            margin: EdgeInsets.only(
                                                                                              right: MediaQuery.of(context).size.width * 0.2,
                                                                                            ),
                                                                                            child: Text("${controller.listpoduct_favorite.elementAt(index).selling_price}" + " ل.س ", style: TextStyle(color: Colors.red, fontSize: 12))),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ]),
                                                                              ],
                                                                            ),
                                                                          ]),
                                                                      SizedBox(
                                                                        width:
                                                                            25,
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ]),
                                                          ]);
                                                    })),
                                            Row(children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 150,
                                                      top: 1,
                                                      bottom: 10),
                                                  child: TextButton(
                                                    child: Text("عرض المزيد",
                                                        style:
                                                            Themes.subtitle2),
                                                    onPressed: () {
                                                      Get.to(Seggestions(
                                                        title:
                                                            "اقتراحات قد تعجبك",
                                                        products: controller
                                                            .listpoduct_favorite,
                                                      ));
                                                    },
                                                  ))
                                            ]),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 80, left: 80),
                                              child: Divider(),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ]),

/////////////////////////////////                   /listpoduct_sales
                                    sampleController2.listpoduct_sales.isEmpty
                                        ? SizedBox.shrink()
                                        : Column(
                                            children: [
                                              Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.5,
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: controller
                                                          .listpoduct_sales
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var item = controller
                                                            .listpoduct_sales;
                                                        return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              index == 0
                                                                  ? Row(
                                                                      children: [
                                                                        InkWell(
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 20, bottom: 10),
                                                                            child:
                                                                                Text(" الأكثر شيوعا  ", style: Themes.headline1),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            Get.to(Seggestions(
                                                                              title: "الأكثر شيوعاً",
                                                                              products: controller.listpoduct_sales,
                                                                            ));
                                                                          },
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              right: 40,
                                                                              bottom: 8),
                                                                          child: IconButton(
                                                                              onPressed: () {
                                                                                Get.to(Seggestions(
                                                                                  title: "الأكثر شيوعاً",
                                                                                  products: controller.listpoduct_sales,
                                                                                ));
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.arrow_forward,
                                                                                color: sampleController3.col == 1 ? Colors.white : Themes.color3,
                                                                                size: 20,
                                                                              )),
                                                                        )
                                                                      ],
                                                                    )
                                                                  : Row(
                                                                      children: [
                                                                        InkWell(
                                                                          child: Container(
                                                                              margin: EdgeInsets.only(right: 30, bottom: 40),
                                                                              child: Text("    ")),
                                                                        ),
                                                                      ],
                                                                    ),
                                                              Column(children: [
                                                                SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Column(
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Stack(
                                                                                    children: [
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          Get.to(ProductDeatil(controller.listpoduct_sales.elementAt(index).id));
                                                                                        },
                                                                                        child: Container(
                                                                                          margin: EdgeInsets.only(right: 10),
                                                                                          width: MediaQuery.of(context).size.width * 0.75,
                                                                                          height: MediaQuery.of(context).size.height * 0.3,
                                                                                          child: ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(20),
                                                                                            child: Image.network(
                                                                                              "${MyApp.api}/uploads/product/${item.elementAt(index).image}",
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Positioned(
                                                                                        left: 10,
                                                                                        top: 15,
                                                                                        child: InkWell(
                                                                                          onTap: () async {
                                                                                            var data = await AuthServices.doo(product_id: controller.listpoduct_sales.elementAt(index).id);
                                                                                            if (data == "add") {
                                                                                              Favorite_product2 g = new Favorite_product2(product_id: controller.listpoduct_sales.elementAt(index).id, id: 9);
                                                                                              controller.listpoduct_f.add(g);

                                                                                              controller.listpoduct_sales.elementAt(index).isFavourite = true;
                                                                                              controller.changeCol(data, 1, controller.listpoduct_sales.elementAt(index).id);
                                                                                            } else {
                                                                                              controller.listpoduct_sales.elementAt(index).isFavourite = false;

                                                                                              for (int i = 0; i < controller.listpoduct_f.length; i++) {
                                                                                                if (controller.listpoduct_sales.elementAt(index).id == controller.listpoduct_f.elementAt(i).product_id) controller.listpoduct_f.removeAt(i);
                                                                                              }

                                                                                              controller.changeCol(data, 2, controller.listpoduct_sales.elementAt(index).id);
                                                                                            }
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            backgroundColor: Themes.color2,
                                                                                            child: Icon(
                                                                                              Icons.favorite,
                                                                                              color: controller.check(controller.listpoduct_sales.elementAt(index).id) ? Colors.red : Colors.black,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Row(children: [
                                                                                    Container(
                                                                                      margin: EdgeInsets.only(right: 20),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text("${controller.listpoduct_sales.elementAt(index).product_name} ", style: Themes.bodyText1),
                                                                                          SizedBox(
                                                                                            width: 5,
                                                                                          ),
                                                                                          Icon(
                                                                                            controller.listpoduct_sales[index].rating == 0
                                                                                                ? Icons.mood_bad
                                                                                                : controller.listpoduct_sales[index].rating == 1
                                                                                                    ? Icons.sentiment_satisfied
                                                                                                    : Icons.sentiment_very_satisfied_outlined,
                                                                                            color: controller.listpoduct_sales[index].rating == 0
                                                                                                ? Colors.red
                                                                                                : controller.listpoduct_sales[index].rating == 1
                                                                                                    ? Colors.orange
                                                                                                    : Colors.green,
                                                                                          ),
                                                                                          Container(
                                                                                              margin: EdgeInsets.only(
                                                                                                right: MediaQuery.of(context).size.width * 0.2,
                                                                                              ),
                                                                                              child: Text("${controller.listpoduct_sales.elementAt(index).selling_price}" + " ل.س ", style: TextStyle(color: Colors.red, fontSize: 12))),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ]),
                                                                                ],
                                                                              ),
                                                                            ]),
                                                                        SizedBox(
                                                                          width:
                                                                              25,
                                                                        ),
                                                                      ]),
                                                                ),
                                                              ]),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                            ]);
                                                      })),
                                              Row(children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 150,
                                                        top: 1,
                                                        bottom: 10),
                                                    child: TextButton(
                                                      child: Text("عرض المزيد",
                                                          style:
                                                              Themes.subtitle2),
                                                      onPressed: () {
                                                        Get.to(Seggestions(
                                                          title:
                                                              "الأكثر شيوعاً",
                                                          products: controller
                                                              .listpoduct_sales,
                                                        ));
                                                      },
                                                    ))
                                              ]),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 80, left: 80),
                                                child: Divider(),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),
/////////////////////////////////                  /listpoduct_salary

                                    sampleController2.listpoduct_salary.isEmpty
                                        ? SizedBox.shrink()
                                        : Column(
                                            children: [
                                              Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.5,
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: controller
                                                          .listpoduct_salary
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var item = controller
                                                            .listpoduct_salary;
                                                        return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              index == 0
                                                                  ? Row(
                                                                      children: [
                                                                        InkWell(
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 22, bottom: 10),
                                                                            child:
                                                                                Text("الأقل سعرا", style: Themes.headline1),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            Get.to(Seggestions(
                                                                              title: "الأقل سعراً",
                                                                              products: controller.listpoduct_salary,
                                                                            ));
                                                                          },
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              right: 30,
                                                                              bottom: 8),
                                                                          child: IconButton(
                                                                              onPressed: () {
                                                                                Get.to(Seggestions(
                                                                                  title: "الأقل سعراً",
                                                                                  products: controller.listpoduct_salary,
                                                                                ));
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.arrow_forward,
                                                                                color: sampleController3.col == 1 ? Colors.white : Themes.color3,
                                                                                size: 25,
                                                                              )),
                                                                        )
                                                                      ],
                                                                    )
                                                                  : Row(
                                                                      children: [
                                                                        InkWell(
                                                                          child: Container(
                                                                              margin: EdgeInsets.only(right: 28, bottom: 40),
                                                                              child: Text("    ")),
                                                                        ),
                                                                      ],
                                                                    ),
                                                              Column(children: [
                                                                SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Column(
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Stack(
                                                                                    children: [
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          Get.to(ProductDeatil(controller.listpoduct_salary.elementAt(index).id));
                                                                                        },
                                                                                        child: Container(
                                                                                          margin: EdgeInsets.only(right: 10),
                                                                                          width: MediaQuery.of(context).size.width * 0.75,
                                                                                          height: MediaQuery.of(context).size.height * 0.3,
                                                                                          child: ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(20),
                                                                                            child: Image.network(
                                                                                              "${MyApp.api}/uploads/product/${item.elementAt(index).image}",
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Positioned(
                                                                                        left: 10,
                                                                                        top: 15,
                                                                                        child: InkWell(
                                                                                          onTap: () async {
                                                                                            var data = await AuthServices.doo(product_id: controller.listpoduct_salary.elementAt(index).id);
                                                                                            if (data == "add") {
                                                                                              controller.listpoduct_salary.elementAt(index).isFavourite = true;

                                                                                              Favorite_product2 g = new Favorite_product2(product_id: controller.listpoduct_salary.elementAt(index).id, id: 9);
                                                                                              controller.listpoduct_f.add(g);
                                                                                            } else {
                                                                                              controller.listpoduct_salary.elementAt(index).isFavourite = false;

                                                                                              for (int i = 0; i < controller.listpoduct_f.length; i++) {
                                                                                                if (controller.listpoduct_salary.elementAt(index).id == controller.listpoduct_f.elementAt(i).product_id) controller.listpoduct_f.removeAt(i);
                                                                                              }
                                                                                              controller.changeCol(data, 2, controller.listpoduct_salary.elementAt(index).id);
                                                                                            }
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            backgroundColor: Themes.color2,
                                                                                            child: Icon(
                                                                                              Icons.favorite,
                                                                                              color: controller.check(controller.listpoduct_salary.elementAt(index).id) ? Colors.red : Colors.black,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(children: [
                                                                                    Container(
                                                                                      margin: EdgeInsets.only(right: 20),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text("${controller.listpoduct_salary.elementAt(index).product_name} ", style: Themes.bodyText1),
                                                                                          SizedBox(
                                                                                            width: 5,
                                                                                          ),
                                                                                          Icon(
                                                                                            controller.listpoduct_salary[index].rating == 0
                                                                                                ? Icons.mood_bad
                                                                                                : controller.listpoduct_salary[index].rating == 1
                                                                                                    ? Icons.sentiment_satisfied
                                                                                                    : Icons.sentiment_very_satisfied_outlined,
                                                                                            color: controller.listpoduct_salary[index].rating == 0
                                                                                                ? Colors.red
                                                                                                : controller.listpoduct_salary[index].rating == 1
                                                                                                    ? Colors.orange
                                                                                                    : Colors.green,

//  sampleController3.col==1?Colors.white: Colors.green,
                                                                                          ),
                                                                                          Container(
                                                                                              margin: EdgeInsets.only(
                                                                                                right: MediaQuery.of(context).size.width * 0.2,
                                                                                              ),
                                                                                              child: Text("${controller.listpoduct_salary.elementAt(index).selling_price}" + " ل.س ", style: TextStyle(color: Colors.red, fontSize: 12))),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ]),
                                                                                ],
                                                                              ),
                                                                            ]),
                                                                        SizedBox(
                                                                          width:
                                                                              25,
                                                                        ),
                                                                      ]),
                                                                ),
                                                              ]),
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                            ]);
                                                      })),
                                              Row(children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 150,
                                                        top: 1,
                                                        bottom: 1),
                                                    child: TextButton(
                                                      child: Text("عرض المزيد",
                                                          style:
                                                              Themes.subtitle2),
                                                      onPressed: () {
                                                        Get.to(Seggestions(
                                                            title:
                                                                "الأقل سعراً",
                                                            products: controller
                                                                .listpoduct_salary));
                                                      },
                                                    ))
                                              ]),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 80, left: 80),
                                                child: Divider(),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )));
                          })
                        ]);
                      }));
                })),
      ),
    );
  }
}
