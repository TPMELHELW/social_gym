import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_app/features/chat/model/message_model.dart';

class ChatModel {
  final List<String> id;
  final List<MessageModel> messages;

  ChatModel(
      {required this.id,
      // required this.recivedId,
      required this.messages});

  factory ChatModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ChatModel(
      messages: data['Chats'] ?? [],
      id: data['Id'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Messages': messages.map((value) => value.toJson()).toList(),
    };
  }
}
