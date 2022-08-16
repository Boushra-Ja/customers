import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../logic/controllers/products/RatingProductController.dart';
import '../utls/Themes.dart';

class EvaluationDialoge extends StatelessWidget {
  var product_id ;
  EvaluationDialoge(this.product_id);

  @override
  Widget build(BuildContext context) {
    RatingProductController controller = Get.put(RatingProductController(product_id)) ;

    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx((){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/report.png'), fit: BoxFit.contain),
                ),
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.mood_bad),
                      onPressed: (){
                        controller.select_smile.value = 0 ;
                      },
                      iconSize:controller.select_smile.value==0 ? 40 : 35,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    IconButton(
                      icon: Icon(Icons.sentiment_satisfied),
                      onPressed: (){
                        controller.select_smile.value = 1;
                      },
                      iconSize:controller.select_smile.value==1 ? 40 : 35,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    IconButton(
                      icon: Icon(Icons.sentiment_very_satisfied_outlined),
                      onPressed: (){
                        controller.select_smile.value = 2 ;
                      },
                      iconSize:controller.select_smile.value==2 ? 40 : 35,
                      color: Colors.green,
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child:  Form(
                  key: controller.formstate,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (val) {
                      controller.notes = val.toString() ;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(30)),
                        hintText: 'ادخل تعليقك هنا..',
                        hintStyle: Themes.subtitle1,
                        contentPadding: EdgeInsets.fromLTRB(
                            10.0,20, 20.0, 20),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ) ,
                  Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Themes.color,),


                      onPressed: () {
                        Get.back();
                      },
                      child : Text('تخطي' , style: TextStyle(color: Colors.white))
                  ), flex: 2, ) ,
                  Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ) ,
                  Expanded(
                    flex: 2,
                    child:  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Themes.color,),

                        onPressed: () {
                          var form = controller.formstate.currentState;
                          form!.save();
                          controller.rating_product() ;
                          Get.back() ;
                          Get.snackbar("", "شكراا على تفاعلك ^_^") ;

                        },
                        child : Text('تقييم' , style: TextStyle(color: Colors.white))
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ) ,

                ],)
            ],
          );
        }),
      ),
    );
  }
}
