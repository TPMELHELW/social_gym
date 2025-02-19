import 'package:gym_app/features/chat/model/message_model.dart';

class ChatedFriendsModel {
  final String id;
  final String userName;
  MessageModel lastMessage;

  ChatedFriendsModel({
    required this.id,
    required this.userName,
    required this.lastMessage,
  });

  factory ChatedFriendsModel.fromSnapshot(
      Map<String, dynamic> data, MessageModel lastMessage) {
    return ChatedFriendsModel(
        id: data['Id'] ?? '',
        userName: data['UserName'] ?? '',
        lastMessage: lastMessage);
  }
}
