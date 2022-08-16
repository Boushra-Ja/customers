
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controllers/DrawerController/SettingPageController.dart';
import '../../utls/Themes.dart';
import '../ConstantPages/RoundedAppBar.dart';

class NotificationPage extends GetView<SettingPageController>{
  final sampleController3 = Get.put(SettingPageController(), permanent: true);

  @override
  Widget build(BuildContext context) {
   return Directionality(textDirection: TextDirection.rtl, child: Scaffold(

     appBar: RoundedAppBar(),

     backgroundColor: sampleController3.col==0?Themes.color2: Colors.black,
     body:ListView.builder(
       itemCount: 6,
         itemBuilder:  (BuildContext context, int index){
       return Padding(
         padding: const EdgeInsets.only(left: 10.0 ,right: 10 , bottom: 15 ),
         child: InkWell(
           onTap: (){
             ////Action
           },
           child: ListTile(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
               selected: true,
               contentPadding: EdgeInsets.all(20),
               selectedTileColor: Colors.white,
               leading: CircleAvatar(
                 backgroundImage: AssetImage('images/shop2.jpg'),
                 radius: 35,
               ),
               title: Text(" تم قبول طلبك من قبل المتجر الفلاني وسيتم تسليمه بتاريخ 3/4/2020" , style: Themes.subtitle1,),
               subtitle:Text("امس الساعة 3:00" , style: Themes.subtitle2,)
           ),
         ),
       );
     })
   )) ;
  }


}