import 'package:flutter/material.dart';

import '../main.dart';

class Themes  {
  static const color = Color(0xFFAF3A88);
  static const color2 = Color(0xFFF5EFF3);
  static  Color color3 = Colors.grey.shade600;
  static Color grey_color =  Colors.grey.shade50;
  static const borderColor = Colors.black;
  static Color white_color =  Colors.white;


  static  TextStyle headline1 = TextStyle(fontSize: 18, color: color3, fontWeight: FontWeight.w500, fontFamily: 'Roboto');
  static const headline2 = TextStyle(decoration: TextDecoration.underline, color: color, fontSize: 18);
  static const headline4 = TextStyle(fontSize: 18, color: borderColor, fontWeight: FontWeight.bold);
  static  TextStyle headline3 = TextStyle(fontSize: 20, color: borderColor ,);
  static const headline5 = TextStyle(fontSize: 22, decoration: TextDecoration.underline, color: color);


  static const subtitle1 = TextStyle(fontSize: 14, color: Colors.black87, fontFamily: 'Roboto');
  static  TextStyle subtitle2 = TextStyle(fontSize: 14,color: color3,);
  static TextStyle subtitle3 = TextStyle(fontSize: 12,color:  color3);
  static TextStyle subtitlebat = TextStyle(fontSize: 14,color: sampleController3.col==0?   Colors.black: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle subtitle44 = TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: sampleController3.col==1?Colors.white:Colors.black,);
  static TextStyle button_text = TextStyle(fontSize: 14,color:  white_color);


  static const bodyText1 = TextStyle(fontSize: 16, color: Colors.black , );
  static const bodyText2 = TextStyle(fontSize: 16, color: color);
  static TextStyle bodyText3 = TextStyle(fontSize: 16, color: Colors.grey.shade600);
  static const bodyText4 = TextStyle(fontSize: 16, color: Colors.white);
  static TextStyle bodyText5 = TextStyle(fontSize: 16, color: Colors.grey.shade600);
  static TextStyle bodyText6 = TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold);
  static TextStyle select_option_text = TextStyle(fontSize: 16, color: color3 ,fontWeight: FontWeight.bold );
  static const no_select_text = TextStyle(fontSize: 15, color: Colors.black , );


}
