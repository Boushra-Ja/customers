class MyFavourite {

  int store_id ;

  MyFavourite({required this.store_id}) ;

  factory MyFavourite.fromJson(Map<String , dynamic> json)
  {
    return MyFavourite(store_id : json['store_id']);
  }

}
class MyFavouriteModel{

  List<MyFavourite>data ;
  MyFavouriteModel({required this.data}) ;

  factory MyFavouriteModel.fromJson(Map<String , dynamic> json)
  {
    return MyFavouriteModel(
        data:List<MyFavourite>.from(json['data'].map((p)=>MyFavourite.fromJson(p))).toList()
    ) ;
  }
}