// import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utls/Themes.dart';
import 'ConstantPages/MyCustomCLipper.dart';

class mazad extends StatefulWidget {
  @override
  _mazadState createState() => _mazadState();
}

class _mazadState extends State<mazad> with TickerProviderStateMixin {
  int _counter = 0;
  late AnimationController _controller;
  int levelClock = 15;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
                levelClock));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
        animation: StepTween(
      begin: levelClock, // THIS IS A USER ENTERED NUMBER
      end: 0,
    ).animate(_controller));
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;
  final myProducts = List<String>.generate(1000, (i) => 'Product $i');

  int _counter = 0;
  final messageInsert = TextEditingController();
  List<Map> messsages = [];

  void _incrementCounter() {
    _counter = _counter + 29;
  }

  int i = 0;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(children: <Widget>[
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
                                      onPressed: () {
                                        Get.back();
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
                            Text(
                              "$timerText",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ]),
                        )
                        //   leading: CircleAvatar(radius:80,backgroundImage: AssetImage("images/2.jpg")),
                      ]),
                    ),
                  )),
              Divider(color: Colors.grey),
              Expanded(
                  flex: 4,
                  child: Container(
                      child: ListView.builder(
                          reverse: true,
                          itemCount: messsages.length,
                          itemBuilder: (context, index) => mazad(
                              messsages[index]["message"].toString(),
                              messsages[index]["data"],timerText)))),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                      child: timerText == "0:00"
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
                                  Text(
                                    "${_counter}",
                                    style: TextStyle(
                                        color: Themes.color, fontSize: 18),
                                  ),
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
                                    Text(
                                      "${_counter}",
                                      style: TextStyle(
                                          color: Themes.color, fontSize: 18),
                                    ),
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
                                          onPressed: () {
                                            messsages.insert(0, {
                                              "data": 0,
                                              "message": _counter
                                            });

                                            messageInsert.clear();
                                            i++;

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
            ])));
  }

  Widget mazad(String message, int data,String timerText) {
     // var v=int.parse(timerText);
     // v=30;
    timerText="30";
    print(timerText);
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Card(
        child: ListTile(
          title: Text("بتول الزعبي"),
          subtitle: Row(
            mainAxisAlignment:
                data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              // data == 0 ? Container(
              //   height: 60,
              //   width: 60,
              //   child: CircleAvatar(radius: 10,
              //     backgroundImage: AssetImage("${controller.Images.value}"),
              //   ),
              // ) : Container(),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: Bubble(
                    radius: Radius.circular(15.0),
                    color: data == 0 ? Themes.color : Themes.color2,
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
                              message,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                        ],
                      ),
                    )),
              ),

              // data == 1? Container(
              //   height: 60,
              //   width: 60,
              //   child: CircleAvatar(radius: 10,
              //     backgroundImage: AssetImage("images/3.jpg"),
              //   ),
              // ) : Container(),
            ],
          ),
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("images/jk.jpg"),
          ),
        ),
      ),
    );
  }
}
