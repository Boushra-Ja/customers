
class Notification{

  int id  , sender_id ,  receiver_id , store_id;
  String title ,message   ,created_at , store_image ;

  factory Notification.fromJson(Map<String , dynamic> json)
  {
    return Notification(id : json['id'] , sender_id : json['sender_id'] ,
        receiver_id : json['receiver_id']   , title : json['title'] ,
        message : json['message'] , created_at : json['created_at'] ,
      store_id:json['store_id'] , store_image:json['store_image']
    );
  }

  Notification({required this.id , required this.sender_id , required this.receiver_id  ,
    required this.title , required this.message , required this.created_at,
    required this.store_id , required this.store_image
  });

}


class NotificationModel{

  List<Notification>data ;
  NotificationModel({required this.data}) ;

  factory NotificationModel.fromJson(Map<String , dynamic> json)
  {
    return NotificationModel(
        data:List<Notification>.from(json['data'].map((p)=>Notification.fromJson(p))).toList()
    ) ;
  }
}