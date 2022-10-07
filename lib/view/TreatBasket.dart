import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:get/get.dart';
import '../logic/controllers/cart/TreatBasketController.dart';
import '../logic/controllers/orders/ShoppingBasket.dart';
import '../utls/Themes.dart';
import 'My_Orders/MyDiscounts.dart';


class TreatBasket extends GetView<TreatBasketController> {

  @override
  late DateTime _selectedDate = DateTime.now();
  List<ShoppingBasket> ListInt = [];
  DateTime now = DateTime.now();

  // App widget tree
  @override
  Widget build(BuildContext context) {

    TreatBasketController controller = Get.put(TreatBasketController());
    return  Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body:RefreshIndicator(
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                      ()async {
                    controller.user_id  =  await controller.storage.read(key: 'id') ;
                    controller.maplist=Get.arguments["map"];
                    await controller.fetch_discounts() ;
                  },
                );
              }, child: GetBuilder<TreatBasketController>(builder: (TreatBasketController controller){
              if(!controller.isLoading)
              {
                return Center(child: CircularProgressIndicator(),) ;
              }
              return ListView(children: [
                SizedBox(
                  height: 50,
                ),
                Container(

                  child: Card(
                    elevation:10,  // Change this
                    shadowColor: Themes.color2,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Themes.color2, width: 2),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: EdgeInsets.only(right: 15, left: 15, bottom: 25),
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        Center(
                            child: Text(
                              "قم بتحديد المنتجات التي تريد شرائها",
                              style: Themes.headline1,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:30.0),
                          child: Divider(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),

                          child: GetBuilder<TreatBasketController>(
                              init: TreatBasketController(),
                              builder: (controller) {
                                return ListView.builder(
                                    itemCount: controller.maplist.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContextcontext, int i) {
                                      return Container(
                                        child: CheckboxListTile(
                                            title: Text(
                                              "${controller.maplist.elementAt(i).product_name}",
                                              style: Themes.bodyText1,
                                            ),
                                            subtitle: Text(
                                              "${controller.maplist.elementAt(i).selling_price} ل.س ",
                                              style: TextStyle(
                                                  color: Colors.red, fontSize: 12),
                                            ),
                                            secondary: const Icon(Icons.code),
                                            autofocus: false,
                                            activeColor: Color(0xFFAF3A88),
                                            checkColor: Colors.white,
                                            selected: controller.chexkboxValue.elementAt(i),
                                            value: controller.chexkboxValue.elementAt(i),
                                            onChanged: <Boolean>(value) {
                                              controller.chexkboxValue[i] = value;

                                              if (value == true) {
                                                ListInt.add(
                                                    controller.maplist.elementAt(i));
                                                controller.total_price+= controller.maplist.elementAt(i).selling_after_dis * controller.maplist.elementAt(i).amount ;

                                              } else {
                                                ListInt.remove(
                                                    controller.maplist.elementAt(i));
                                                controller.total_price-= controller.maplist.elementAt(i).selling_after_dis * controller.maplist.elementAt(i).amount;

                                              }

                                              print('total_price  ${controller.total_price}');
                                              controller.setchexkboxValue(
                                                  value,
                                                  i);
                                            }),
                                      );
                                    });
                              }),
                        ),
                        SizedBox(height: 50,),

                      ],
                    ),
                  ),),

                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Card(
                    elevation:10,  // Change this
                    shadowColor: Themes.color2,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Themes.color2, width: 2),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: EdgeInsets.only(right: 15, left: 15, bottom: 25),
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        Center(
                            child: Text(
                              "الوقت المتوقع للرد على الطلب",
                              style: Themes.headline1,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(children: [
                            DatePickerWidget(
                              looping: false,
                              // default is not looping
                              firstDate: DateTime(2022, 01, 01),
                              lastDate: DateTime(2030, 1, 1),
                              initialDate: DateTime(2022, 10, 12),
                              dateFormat: "dd-MMM-yyyy",
                              locale: DatePicker.localeFromString('en'),
                              onChange: (DateTime newDate, _) => _selectedDate = newDate,
                              pickerTheme: const DateTimePickerTheme(
                                itemTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                                dividerColor: Themes.color,
                                backgroundColor: Themes.color2,
                              ),
                            ),

                            SizedBox(height: 50,),

                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(child: Card(
                  elevation:10,  // Change this
                  shadowColor: Themes.color2,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Themes.color2, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: EdgeInsets.only(right: 15, left: 15, bottom: 25),
                  child:  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(" لاستخدام أحد خصوماتك اضغط هنا" , style: Themes.subtitle2,) , flex: 4,),
                        Expanded(child: IconButton(icon: Icon(Icons.fast_rewind_rounded), onPressed: (){
                          Get.to(MyDiscounts()) ;
                        },), flex: 1,),

                      ],
                    ),
                  ),
                ),),
                GetBuilder<TreatBasketController>(builder: (controller){
                  return controller.isAdd  ?Center(
                    child: FloatingActionButton.extended(

                      onPressed: () async {
                        if(ListInt.isEmpty)
                          Get.snackbar("لا يمكن إرسال طلب فارغ :(", "الرجاء اختيار أحد المنتجات.." ) ;

                        else
                        {

                          return AwesomeDialog(
                              context: context,
                              dialogType: DialogType.QUESTION,
                              borderSide: BorderSide(color: Colors.green, width: 2),
                              buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                              headerAnimationLoop: false,
                              animType: AnimType.BOTTOMSLIDE,
                              title: ' تأكيد الطلب ',
                              desc: 'هل تريد تحويل الطلب للمشرفين؟؟',
                              showCloseIcon: true,
                              btnOkColor: Themes.color,
                              btnCancelColor: Colors.grey,
                              btnOkText: "تأكيد",
                              btnCancelText: "إلغاء",
                              btnCancelOnPress: () {},
                              btnOkOnPress: () async{

                                ListInt.elementAt(0).delivery_time = _selectedDate.toString() ;
                                await controller.AddOrder();
                                for (int i = 0; i < ListInt.length; i++) {

                                  await controller.AddOrderProduct(
                                      product_id: ListInt.elementAt(i).product_id,
                                      order_id:
                                      controller.maplist.elementAt(0).order_id,
                                      amount: ListInt.elementAt(i).amount,
                                      gift_order: ListInt.elementAt(i).gift_order,
                                      ind: i);

                                  await controller.storage_options(i);
                                }

                                if(controller.cnt.value == ListInt.length+1)
                                {
                                  for (int i = 0; i < ListInt.length; i++)
                                  {
                                    await controller.deleteFromBasket(ListInt.elementAt(i).store_id, ListInt.elementAt(i).product_id) ;
                                  }
                                  Get.back();
                                  Get.back();
                                  Get.snackbar("تم إرسال الطلب بنجاح ", "سيصلك الرد قريبا..");
                                  controller.set_isAdd(true) ;

                                }


                              }).show();
                        }
                      },
                      backgroundColor: Themes.color,
                      foregroundColor: Themes.color2,
                      label: Text("إرسال الطلب"),
                    ),
                  ) : Center(child: CircularProgressIndicator(),);
                },),
                SizedBox(height: 40,)

              ]);
            },),)
        ));

  }
}



