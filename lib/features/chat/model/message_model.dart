class MessageModel {
  final String message;
  final String id;

  MessageModel({required this.message, required this.id});

  factory MessageModel.fromSnapshot(Map<String, dynamic> data) {
    return MessageModel(
      message: data['Message'] ?? '',
      id: data['Id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Message': message,
      'Id': id,
    };
  }
}
