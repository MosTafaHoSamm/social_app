class MessageModel {
  String receiverId;
  String text;
  String dateTime;
  MessageModel({this.receiverId,this.text,this.dateTime});
  MessageModel.fromJson(Map<String,dynamic>json){
    receiverId=json['receiverId'];
    text=json['text'];
    dateTime=json['dateTime'];
  }
  Map<String,dynamic>toMap(){
    return{
      'receiverId':receiverId,
      'text':text,
      'dateTime':dateTime,
    };
  }

}
