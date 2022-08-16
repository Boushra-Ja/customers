
class ClassificationModel{

  List<Classifications>data ;
  ClassificationModel({required this.data}) ;

  factory ClassificationModel.fromJson(Map<String , dynamic> json)
  {
    return ClassificationModel(
        data:List<Classifications>.from
          (json['data'].map((p)=>
            Classifications.fromJson(p)))
            .toList()
    ) ;
  }
}

class Classifications {
  late  List<Secondary> mySecondary;
  late var id;
  late var title;
  var X;
  Classifications(
      {
        required this.id,
        required this.title,
        required this.mySecondary,
     });
  Classifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['secendary'] != null) {
      mySecondary = [];
      json['secendary'].forEach((v) {
        mySecondary.add(new Secondary.fromJson(v));
      });
    }

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class Secondary{
  // late var id;
  // late var created_at;
  // late var updated_at;
  late var title;
//  late var classification_id;

  Secondary(
      {
       // required this.id,
        required this.title,
        // required this.created_at,
        // required this.updated_at,
        // required this.classification_id,
      });
  Secondary.fromJson(Map<String, dynamic> json) {
   // id = json['id'];
    title = json['title'];
    // created_at = json['created_at'];
    // updated_at = json['updated_at'];
    // classification_id = json['classification_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['title'] = this.title;
    // data['updated_at'] = this.updated_at;
    // data['created_at'] = this.created_at;
    // data['classification_id'] = this.classification_id;

    return data;
  }




}