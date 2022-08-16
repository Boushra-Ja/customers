
import 'package:get/get.dart';

class EditPageController extends GetxController{

  var selectedColor = "الأحمر".obs ;
  var selectedSize = "10*20".obs ;
  var selectedMaterial = "البلاستيك".obs ;
  var selectedQuantity = "1".obs ;

  var Colorlist = [
    "الأحمر",
    "الأصفر",
    "الأزرق",
  ];

  var Sizelist = [
    "10*20",
    "20*30",
    "30*40",
  ];

  var Materiallist = [

    "البلاستيك" ,
    "الخشب" ,
    "الزجاج"

  ];
  var Quantitylist = [

    "1" ,
    "2" ,
    "3"

  ];

  void setSelectedColor(String val){
    selectedColor.value = val ;
  }
  void setSelectedSize(String val){
    selectedSize.value = val ;
  }
  void setSelectedMaterial(String val){
    selectedMaterial.value = val ;
  }

  void setSelectedQuantity(String val){
    selectedQuantity.value = val ;
  }



}