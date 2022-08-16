
class category2Model{

  List<categories2>data ;
  category2Model({required this.data}) ;

  factory category2Model.fromJson(Map<String , dynamic> json)
  {
    return category2Model(
        data:List<categories2>.from(json['data'].map((p)=>categories2.fromJson(p)))
    ) ;
  }
}



class categories2 {
  late int id;
  late int classification_id;
  late  String title;


  categories2(
      {
        required this.id,
        required this.classification_id,

        required  this.title,
      });

  categories2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    classification_id = json['classification_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['classification_id'] = this.classification_id;

    return data;
  }
}