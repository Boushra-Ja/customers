import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utls/Themes.dart';

class InfoApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(

      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(

              children: [
                SizedBox(height: 20,),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/wel.jpg'),
                        fit: BoxFit.contain),
                  ),
                ),
                SizedBox(height: 20,) ,
                Text("*هدفنا هو جمع كل أصحاب الحرف والفنانين وأصحاب المشاريع الصغيرة معا في منصة واحدة تؤمن للمستخدم الحصول على ما يريد وبأفضل طريقة وجودة .." , style: Themes.bodyText2,),
                SizedBox(height: 20,),
                Text("*يؤمن تطبيقنا واجهات مريحة للمستخدم وسهولة استخدام لجميع الفئات.." ,  style: Themes.bodyText3),
                SizedBox(height: 10,) ,
                Text("*كما نؤمن لك الاطلاع على أحدث المنتجات و الأكثر بيعا و شهرة.." ,  style: Themes.bodyText3),
                SizedBox(height: 10,) ,
                Text("امكانية طلب منتجات بمواصفات خاصة تناسب حاجتك.." ,  style: Themes.bodyText3),
                SizedBox(height: 10,) ,
                Text("*طريقة شراء آمنة مع امكانية التبديل او الترجيع ضمن شروط محددة.." ,  style: Themes.bodyText3),
                SizedBox(height: 10,) ,
                Text("*توصيل طلبك لأقرب مكان لك.." ,  style: Themes.bodyText3) ,
                SizedBox(height: 10,),
                Text("*عمليات بحث مريحة ومساعدة لك.." ,  style: Themes.bodyText3) ,
                SizedBox(height: 10,) ,
                Text("*الوصول الى عناصرك المفضلة بسهولة.." ,  style: Themes.bodyText3),
                SizedBox(height: 50,) ,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(thickness: 1,),
                ),
                Center(
                  child: Text(
                    "الإصدار 1.0.0.0",
                    style: Themes.subtitle3,
                  ),
                ),
                SizedBox(height: 20,) ,


              ],
            ),
          ),
        ],
      ),
    )) ;
  }
}