// import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../logic/controllers/Notification/MazadController.dart';
import '../logic/controllers/Notification/SingltoneMazad.dart';
import '../main.dart';
import '../services/auth_services.dart';
import '../utls/Themes.dart';
import 'ConstantPages/MyCustomCLipper.dart';

class Mazad extends GetView<MazadController> {

  final controller = Get.put(MazadController());
  Widget mazad(String name,int number, int data ) {

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Card(
        child: ListTile(
          title:Row(
              mainAxisAlignment:
              data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [





                Text("${name}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),]),
          subtitle: Row(
            mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [


              Padding(
                padding: EdgeInsets.all(10.0),
                child: Bubble(
                    radius: Radius.circular(15.0),
                    color: data == 0 ? Colors.red : Colors.teal,
                    elevation: 0.0,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 200),
                                child: Text(
                                  '${number}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                        ],
                      ),
                    )),
              ),


            ],
          ),
          // leading: CircleAvatar(
          //   radius: 40,
          //   backgroundImage: AssetImage("images/jk.jpg"),
          // ),
        ),
      ),
    );
  }

   int  raise_id ;
  Mazad(this.raise_id) ;

  @override
  Widget build(BuildContext context) {

    final controller2 = Get.put(SingltoneMazad());

    void _incrementCounter() {
      controller.count.value =   controller.count.value + 20;
    }

    int i = 0;

    return  Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            body:
            Obx(()=>  Column(children: <Widget>[
              ClipPath(
                child: Container(
                  color: Themes.color,
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Themes.color2,
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () async{

                                        if(controller.counter.value==0)
                                        {
                                          print("**************");
                                          print(controller.count.value);
                                          print(raise_id) ;
                                          await AuthServices.EndRaise(
                                            raise_id : raise_id,
                                            price:controller.count.value,
                                            token: await storage.read(key: 'token')

                                          );
                                          Get.back();


                                        }
                                        // controller2.disconnectPusher();
                                      },
                                      icon: Icon(
                                        // MdiIcons.cameraRear,
                                        //  MdiIcons.chevronLeft,
                                        Icons.arrow_back,
                                        color: Themes.color,
                                      ),
                                    ),
                                  ),
                                ),
                              ]))),
                ),
                clipper: MyCustomCLipper(),
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('images/8.jpg'),
                              fit: BoxFit.fill,
                            ),
                            // border: Border.all(
                            //   width: 1,
                            // ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Column(children: [
                            Text(
                              "الوقت المتبقي",
                              style: Themes.headline3,
                            ),
                            Obx(() => Text(
                              "${controller.counter.value}"+":00",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),)
                            ),
                          ]),
                        )
                      ]),
                    ),
                  )),
              Divider(color: Colors.grey),
              Expanded(
                  flex: 4,
                  child: Container(
                      child: ListView.builder(
                          reverse: true,
                          itemCount: controller.messsages.length,
                          itemBuilder: (context, index) => mazad(
                              controller.messsages[index]["name"].toString(),
                              int.parse(controller.messsages[index]["number"].toString()),
                              controller.messsages[index]["data"])))),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                      child: controller.counter.value== 0
                          ? Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "المبلغ الحالي  ",
                              style: Themes.headline1,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Obx(() => Text(
                              "${controller.count.value}",
                              style: TextStyle(
                                  color: Themes.color, fontSize: 18),
                            ),)
                          ]),
                        ),
                      )
                          : Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 60,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.all(Radius.circular(
                            //   15)),
                            color: Colors.purple[50],
                          ),
                          child: Container(
                            color: Colors.grey.shade50,
                            child: Row(children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "المبلغ الحالي  ",
                                style: Themes.headline1,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Obx(() =>Text(
                                "${controller.count.value}",
                                style: TextStyle(
                                    color: Themes.color, fontSize: 18),
                              ),)
                            ]),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                          ),

                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _incrementCounter();
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: Colors.grey.shade600,
                                    size: 25,
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      size: 25.0,
                                      color: Colors.grey.shade600,
                                    ),
                                    onPressed: () async {
                                      controller.messsages.insert(0, {
                                        "data": 0,
                                        "name":controller.name.value,
                                        "number":controller.count.value,
                                      });
                                      if(controller.counter.value!=0)

                                        controller.counter.value=30;
                                      i++;
                                      await AuthServices.storeRaise(
                                          raise_id : raise_id,
                                          customer_id:(await storage.read(key: 'id')),
                                          token: (await storage.read(key: 'token')),
                                          number:controller.count.value

                                      );


                                      // else if(controller.counter.value==0)
                                      //   {
                                      //     print("))))))))))))))))))))))))))))))))))))))))))))))");
                                      //     print(controller.count.value);
                                      //     await AuthServices.EndRaise(
                                      //         raise_id : 1,
                                      //         price:controller.count.value,
                                      //
                                      //     );
                                      //
                                      //
                                      //
                                      //   }


                                      FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                    }),
                              ]),

                          //  Text("${_counter}"),
                        ),
                      ])),
                ),
              ),
            ]))));
  }

}


