class MessageModel {
  final String message;
  final String id;
  final DateTime sendAt;

  MessageModel({required this.message, required this.id, required this.sendAt});

  factory MessageModel.fromSnapshot(Map<String, dynamic> data) {
    return MessageModel(
      message: data['Message'] ?? '',
      id: data['Id'] ?? '',
      sendAt: data['SendAt'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Message': message,
      'Id': id,
      'SendAt': sendAt,
    };
  }
}
