class MessageModel
{
  String? senderId;
  String? receiverId;
  late String text;
  String? dateTime;

  MessageModel({
    this.senderId,
    this.receiverId,
    required this.text,
    this.dateTime,
  });

  MessageModel.fromJson(Map<String,dynamic>json)
  {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'text':text,
      'dateTime':dateTime,
    };
  }
}