
import 'AllChatModel.dart';

class ChatDetailsModel{

  List<ChatDetails>data ;
  ChatDetailsModel({required this.data}) ;

  factory ChatDetailsModel.fromJson(Map<String , dynamic> json)
  {
    return ChatDetailsModel(
        data:List<ChatDetails>.from(json['data'].map((p)=>ChatDetails.fromJson(p)))
    ) ;
  }
}



class ChatDetails {




  late var chats_id;
  late var created_at;
  late var updated_at;
  late var deleted_at;
  late var message;
  late  var id;
  late  var sender_id;



  ChatDetails(
      {
        required this.chats_id,
        required this.message,
        required  this.sender_id,
        required  this.id,

        required  this.deleted_at,
        required  this.created_at,
        required  this.updated_at,
      });

  ChatDetails.fromJson(Map<String, dynamic> json) {
    chats_id = json['chats_id'].toString();

    message = json['message'].toString();
    sender_id = json['sender_id'];
    id = json['id'];
    deleted_at = json['deleted_at'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chats_id'] = this.chats_id;
    data['message'] = this.message;
    data['sender_id'] = this.sender_id;
    data['id'] = this.id;
    data['deleted_at'] = this.deleted_at;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;

    return data;
  }
}