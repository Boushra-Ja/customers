import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controllers/ShopsController/ShopProfileController.dart';
import '../../utls/Themes.dart';

class RatingStore extends StatelessWidget{

  ShopProfileController controller = Get.find<ShopProfileController>() ;
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Container(
        width: MediaQuery.of(context).size.width ,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 5,) ,
                    IconButton(
                      icon: Icon(Icons.star),
                      color:  controller.check_star.elementAt(0) == false ? Colors.grey.shade400 : Colors.yellow.shade700,
                      iconSize: 35,
                      onPressed: (){
                        if(controller.check_star.elementAt(0) == false)
                        {
                          controller.check_star[0] = true ;
                          controller.select_star++;
                        }
                        else{
                          controller.check_star[0] = false ;
                          controller.select_star--;
                        }

                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.star),
                      color:  controller.check_star.elementAt(1) == false ? Colors.grey.shade400 : Colors.yellow.shade700,
                      iconSize: 35,
                      onPressed: (){
                        if(controller.check_star.elementAt(1) == false)
                        {
                          controller.check_star[1] = true ;
                          controller.select_star++;
                        }
                        else{
                          controller.check_star[1] = false ;
                          controller.select_star--;
                        }

                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.star),
                      color:  controller.check_star.elementAt(2) == false ? Colors.grey.shade400 : Colors.yellow.shade700,
                      iconSize: 35,
                      onPressed: (){
                        if(controller.check_star.elementAt(2) == false)
                        {
                          controller.check_star[2] = true ;
                          controller.select_star++;
                        }
                        else{
                          controller.check_star[2] = false ;
                          controller.select_star--;
                        }

                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.star),
                      color:  controller.check_star.elementAt(3) == false ? Colors.grey.shade400 : Colors.yellow.shade700,
                      iconSize: 35,
                      onPressed: (){
                        if(controller.check_star.elementAt(3) == false)
                        {
                          controller.check_star[3] = true ;
                          controller.select_star++;
                        }
                        else{
                          controller.check_star[3] = false ;
                          controller.select_star--;
                        }

                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.star),
                      color:  controller.check_star.elementAt(4) == false ? Colors.grey.shade400 : Colors.yellow.shade700,
                      iconSize: 35,
                      onPressed: (){
                        if(controller.check_star.elementAt(4) == false)
                        {
                          controller.check_star[4] = true ;
                          controller.select_star++;
                        }
                        else{
                          controller.check_star[4] = false ;
                          controller.select_star--;
                        }

                      },
                    ),
                    SizedBox(width: 5,) ,
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
                        fillColor: Colors.grey.shade50.withOpacity(0.8)),
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Themes.color,),

                        onPressed: () {
                          controller.rating_store() ;

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
          ),
        ),
      );
    });
  }
}