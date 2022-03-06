class MessagesModel {
  late String textMessage;
  late String dateTime;
  late String senderId;
  late String receiverId;

  MessagesModel({
    required this.textMessage,
    required this.dateTime,
    required this.senderId,
    required this.receiverId,
  });

  MessagesModel.fromJson(json) {
    textMessage = json['text_message'];
    dateTime = json['date_time'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text_message': textMessage,
      'date_time': dateTime,
      'sender_id': senderId,
      'receiver_id': receiverId,
    };
  }
}