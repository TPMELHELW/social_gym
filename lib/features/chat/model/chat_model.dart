import 'package:gym_app/features/chat/model/message_model.dart';

class ChatModel {
  final List usersId;
  MessageModel lastMessage;
  final String chatId;
  final String userName;
  final List? usersDetails;

  ChatModel({
    this.chatId = '',
    this.userName = '',
    required this.lastMessage,
    this.usersDetails,
    required this.usersId,
  });

  factory ChatModel.fromSnapshot(Map<String, dynamic> data, String id) {
    return ChatModel(
      chatId: id,
      userName: data['UserName'] ?? '',
      lastMessage: data['LastMessage'] ?? {},
      usersId: data['UsersId'] ?? [],
      usersDetails: data['UsersDetails'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UsersId': usersId,
      'LastMessage': lastMessage.toJson(),
      'UsersDetails': usersDetails,
    };
  }
}
