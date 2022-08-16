


class FavoriteStore {
  var store_id ,
      shop_name ,
      image ,status,   num_cell ,all_review ;
  int review =  0;


  factory FavoriteStore.fromJson(Map<String , dynamic> json)
  {

    return FavoriteStore(store_id : json['store_id'] ,shop_name: json['shop_name'],image: json['image']
       ,num_cell: json['num_cell'],
        all_review: json['review'] , review:json['rate'] );
  }

  FavoriteStore({required this.store_id , required this.shop_name, required this.image,
   required this.num_cell , required this.all_review , required this.review });


}

class FavoriteStoreModel{

  List<FavoriteStore>data ;
  FavoriteStoreModel({required this.data}) ;

  factory FavoriteStoreModel.fromJson(Map<String , dynamic> json)
  {
    return FavoriteStoreModel(
        data:List<FavoriteStore>.from(json['data'].map((p)=>FavoriteStore.fromJson(p))).toList()
    ) ;
  }
}