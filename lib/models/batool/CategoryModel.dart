
class categoryModel{

  List<categories>data ;
  categoryModel({required this.data}) ;

  factory categoryModel.fromJson(Map<String , dynamic> json)
  {
    return categoryModel(
        data:List<categories>.from(json['data'].map((p)=>categories.fromJson(p)))
    ) ;
  }
}



class categories {
 late int id;
 late  String title;


 categories(
      {
        required this.id,

        required  this.title,
       });

 categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;

    return data;
  }
}