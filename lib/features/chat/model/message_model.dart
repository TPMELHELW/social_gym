import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String id;
  final DateTime sendAt;
  final MessageModel? repliedMessage;

  MessageModel({
    required this.message,
    required this.id,
    required this.sendAt,
    this.repliedMessage,
  });

  factory MessageModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return MessageModel(
      repliedMessage: data['RepliedMessage'] != null
          ? MessageModel.fromMap(data['RepliedMessage'])
          : null,
      message: data['Message'] ?? '',
      id: data['Id'] ?? '',
      sendAt: data['SendAt'].toDate(),
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    return MessageModel(
      repliedMessage: data['RepliedMessage'] != null
          ? MessageModel.fromMap(data['RepliedMessage'])
          : null,
      message: data['Message'] ?? '',
      id: data['Id'] ?? '',
      sendAt: data['SendAt'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Message': message,
      'Id': id,
      'RepliedMessage': repliedMessage?.toJson(),
      'SendAt': sendAt,
    };
  }
}
