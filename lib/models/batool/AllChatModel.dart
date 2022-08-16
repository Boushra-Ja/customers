
import 'AllChatModel.dart';

class AllChatNodel{

  List<AllChat>data ;
  AllChatNodel({required this.data}) ;

  factory AllChatNodel.fromJson(Map<String , dynamic> json)
  {
    return AllChatNodel(
        data:List<AllChat>.from(

              json['data'].map(
                (p) =>AllChat.fromJson(p))
        )
    );
  }
}



class AllChat {
  late  int chat_id;
  late  String image;
  late  String name;
  late  int receiver_id;



  AllChat(
      {
        required this.chat_id,
        required this.image,
        required  this.name,
        required  this.receiver_id,
      });

  AllChat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    chat_id = json['chat_id'];
    receiver_id = json['receiver_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chat_id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['receiver_id'] = this.receiver_id;

    return data;
  }
}