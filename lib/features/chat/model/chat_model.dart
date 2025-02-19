import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_app/features/chat/model/message_model.dart';

class ChatModel {
  final List<String> usersId;
  // final List<MessageModel> messages;
  final MessageModel lastMessage;
  final String chatId;
  final String userName;

  ChatModel({
    this.chatId = '',
    this.userName = '',
    required this.lastMessage,
    required this.usersId,
  });

  factory ChatModel.fromSnapshot(Map<String, dynamic> data, String id) {
    // final data = document.data()!;
    return ChatModel(
      chatId: id,
      userName: data['UserName'] ?? '',
      lastMessage: data['LastMessage'] ?? {},
      usersId: data['UsersId'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UsersId': usersId,
      'LastMessage': lastMessage.toJson(),
    };
  }
}
