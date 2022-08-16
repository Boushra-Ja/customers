class Option{

  String value  , name;
  var option_type_id , value_id , product_options_id  ;


  factory Option.fromJson(Map<String , dynamic> json)
  {

    return Option(value : json['value'] , name : json['name'] , value_id : json['value_id'] , option_type_id : json['option_type_id'] , product_options_id:json['product_options_id']);
  }

  Option({required this.value , required this.name , required this.value_id , required this.option_type_id , required this.product_options_id});

}


class OptionModel{

  List<Option>data ;
  OptionModel({required this.data}) ;

  factory OptionModel.fromJson(Map<String , dynamic> json)
  {
    return OptionModel(
        data:List<Option>.from(json['data'].map((p)=>Option.fromJson(p))).toList()
    ) ;
  }
}