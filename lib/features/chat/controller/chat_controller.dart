import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/core/services/shared_preferences_services.dart';
import 'package:gym_app/data/chat_repository.dart';
import 'package:gym_app/data/user_repository.dart';
import 'package:gym_app/features/auth/model/user_model.dart';
import 'package:gym_app/features/chat/model/chat_model.dart';
import 'package:gym_app/features/chat/model/message_model.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  ///Variable
  static ChatController get instance => Get.find<ChatController>();
  final UserRepository userRepository = Get.find<UserRepository>();
  final ChatRepository chatRepository = Get.put(ChatRepository());
  late TextEditingController messageController;
  late UserModel currentUser;
  final SharedPreferencesService shardPref =
      Get.find<SharedPreferencesService>();
  MessageModel? repliedMessage;
  List<ChatModel> chatedUserData = [];
  ScrollController scrollController = ScrollController();
  List<UserModel> friendData = [];
  List<MessageModel> chats = [];
  // final HomeController _homeController = Get.put(HomeController());

  void onSlide(MessageModel message) {
    repliedMessage = message;
    update();
  }

  void clearReply() {
    repliedMessage = null;
    update();
  }

  ///Get Freind List Fun
  Future<void> fetchDocuments() async {
    try {
      friendData.clear();
      if (currentUser.friendList.isEmpty) {
        return;
      }
      final QuerySnapshot querySnapshot =
          await userRepository.getSpecialUsers(currentUser.friendList);
      for (var doc in querySnapshot.docs) {
        friendData.add(UserModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>));
      }
      update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  ///Get Messaged Friend
  Future<List<ChatModel>> getMessagedFreind() async {
    try {
      final snapshot = await chatRepository.getMessagedFreind(currentUser.id);
      final chats = <ChatModel>[];
      for (var chat in snapshot.docs) {
        final usersId = chat['UsersId'] as List<dynamic>;
        final otherUserId = usersId.firstWhere(
          (item) => item != currentUser.id,
          orElse: () => null,
        );

        if (otherUserId != null) {
          final filtered = chat['UsersDetails']
              .where((item) => item['UserId'] == otherUserId);
          if (filtered.isNotEmpty) {
            final friend = filtered.first;
            final chatModel = ChatModel.fromSnapshot(
              {
                'UserName': friend['UserName'],
                'UsersId': chat['UsersId'],
                'LastMessage': MessageModel.fromMap(chat['LastMessage']),
              },
              chat.id,
            );
            chats.add(chatModel);
          }
        }
      }

      chatedUserData =
          chats; // Assuming chatedUserData is a class-level variable
      return chats;
    } catch (e) {
      // Handle any errors that occur during the process
      print("Error fetching messaged friends: $e");
      rethrow; // Or return an empty list: return [];
    }
  }

  ///Last Seen Fun
  String getLastSeen(int index) {
    final lastSeenTimestamp =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(friendData[index].lastSeen);
    Duration difference = DateTime.now().difference(lastSeenTimestamp);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return DateFormat('yyyy-MM-dd HH:mm').format(lastSeenTimestamp);
    }
  }

  ///Scrollling down Fun
  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  ///Get Messages Fun
  Stream<List<MessageModel>> getChats(int index, bool isChated) {
    final List<String> users = [
      currentUser.id,
      isChated
          ? chatedUserData[index]
              .usersId
              .firstWhere((item) => item != currentUser.id)
          : friendData[index].id
    ];
    users.sort();
    final String chatId = users.join('-');
    return chatRepository.getMessages(chatId).map((snapshot) {
      final data = snapshot.docs.map((doc) {
        return MessageModel.fromSnapshot(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>);
      }).toList();
      chats = data;
      return data;
    });
  }

  ///Send Message Fun
  Future<void> sendMessage(int index, bool isChated) async {
    try {
      final List<String> users = [
        currentUser.id,
        isChated
            ? chatedUserData[index]
                .usersId
                .firstWhere((item) => item != currentUser.id)
            : friendData[index].id
      ];
      final MessageModel message = MessageModel(
          message: messageController.text,
          id: currentUser.id,
          sendAt: DateTime.now(),
          repliedMessage: repliedMessage);
      final ChatModel chat = ChatModel(
        lastMessage: message,
        usersId: users,
      );
      final ChatModel chat1 = ChatModel(
        lastMessage: message,
        usersId: users,
        usersDetails: [
          {'UserId': users[0], 'UserName': currentUser.userName},
          {'UserId': users[1], 'UserName': friendData[index].userName}
        ],
      );
      users.sort();
      final String chatId = users.join('-');

      if (chats.isEmpty) {
        await chatRepository.createNewChat(chat1.toJson(), chatId);
        await chatRepository.sendFirstMessage(chatId, message.toJson());

        messageController.clear();
        _scrollToBottom();
        update();
        return;
      }

      await chatRepository.sendMessages(
          message.toJson(), chatId, chat.lastMessage.toJson());
      messageController.clear();
      _scrollToBottom();
      clearReply();

      update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  ///Delete Chat
  Future<void> deleteChats(int index, bool isChated) async {
    try {
      final List<String> users = [
        currentUser.id,
        isChated
            ? chatedUserData[index]
                .usersId
                .firstWhere((item) => item != currentUser.id)
            : friendData[index].id
      ];
      users.sort();
      final String chatId = users.join('-');
      await chatRepository.deleteChat(chatId);
      Get.back();
      update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  ///Unfriend Fun
  Future<void> unfriend(int index, bool isChated) async {
    try {
      final filtered = isChated
          ? chatedUserData[index]
              .usersId
              .firstWhere((item) => item != currentUser.id)
          : friendData[index].id;
      currentUser.friendList.remove(filtered);

      await userRepository
          .updateSingleUserInf({'FriendList': currentUser.friendList});
      shardPref.setString('UserData', json.encode(currentUser.toJson()));
      friendData.removeWhere((item) => item.id == filtered);
      Get.back();
      // _homeController.userData = currentUser;
      // _homeController.update();
      update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  @override
  void onInit() async {
    currentUser = UserModel.fromStorage(
        json.decode((await shardPref.getString('UserData'))!));
    await fetchDocuments();
    // getMessagedFreind();
    messageController = TextEditingController();
    super.onInit();
  }
}
