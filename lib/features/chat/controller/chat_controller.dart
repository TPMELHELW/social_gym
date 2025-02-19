import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/core/services/shared_preferences_services.dart';
import 'package:gym_app/data/chat_repository.dart';
import 'package:gym_app/data/user_repository.dart';
import 'package:gym_app/features/auth/model/user_model.dart';
import 'package:gym_app/features/chat/model/chat_model.dart';
import 'package:gym_app/features/chat/model/message_model.dart';
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
  List<ChatModel> chatedUserData = [];
  ScrollController scrollController = ScrollController();
  List<UserModel> friendData = [];
  List<MessageModel> chats = [];

  ///Get Freind List Fun
  Future<void> fetchDocuments() async {
    try {
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
  Stream<List<ChatModel>> getMessagedFreind() {
    return chatRepository
        .getMessagedFreind(currentUser.id)
        .asyncMap((snapshot) async {
      final chats = snapshot.docs;
      for (var chat in chats) {
        final usersId = chat['UsersId'] as List<dynamic>;
        final otherUserId = usersId.firstWhere((item) => item != currentUser.id,
            orElse: () => null);

        final fitered = friendData.where((item) => item.id == otherUserId);
        final data = ChatModel.fromSnapshot({
          'UserName': fitered.single.userName,
          'LastMessage': MessageModel.fromSnapshot(chat['LastMessage'])
        }, chat.id);
        chatedUserData.where((item) => item.chatId == data.chatId).isNotEmpty
            ? null
            : chatedUserData.add(data);
      }
      return chatedUserData;
    });
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

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  ///Get Messages Fun
  Future<void> getChats(int index, bool isChated) async {
    try {
      print(currentUser.id);
      print(currentUser.userName);

      // final data = await chatRepository.getMessages(
      //   [
      //     {
      //       'Id': FirebaseAuth.instance.currentUser!.uid,
      //       'UserName': currentUser.userName
      //     },
      //     {
      //       'Id': isChated ? chatedUserData[index].id : friendData[index].id,
      //       'UserName': isChated
      //           ? chatedUserData[index].userName
      //           : friendData[index].userName,
      //     },
      //   ],
      // );
      // final List gg = data.docs[0]['Messages'];
      // final List<MessageModel> mm =
      //     gg.map((value) => MessageModel.fromSnapshot(value)).toList();

      // chats = mm;
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  ///Send Message Fun
  Future<void> sendMessage(int index) async {
    try {
      final List<String> users = [currentUser.id, friendData[index].id];
      users.sort();
      final String chatId = users.join('-');

      final MessageModel message = MessageModel(
          message: messageController.text,
          id: currentUser.id,
          sendAt: DateTime.now());
      final ChatModel chat = ChatModel(
        lastMessage: message,
        usersId: users,
      );
      await chatRepository.createNewChat(chat.toJson(), chatId);
      if (chats.isEmpty) {
        await chatRepository.sendFirstMessage(chatId, message.toJson());

        // chatedUserData.add(ChatedFriendsModel(
        //   id: friendData[index].id,
        //   userName: friendData[index].userName,
        //   lastMessage: MessageModel(
        //     message: messageController.text,
        //     id: FirebaseAuth.instance.currentUser!.uid,
        //   ),
        // ));
        // chats.add(MessageModel(
        //     message: messageController.text,
        //     id: FirebaseAuth.instance.currentUser!.uid));
        messageController.clear();
        _scrollToBottom();
        update();
        return;
      }

      await chatRepository.sendMessages(
          message.toJson(), chat.toJson(), chatId);
      // chats.add(MessageModel(
      //     message: messageController.text,
      //     id: FirebaseAuth.instance.currentUser!.uid));
      // chatedUserData
      //     .where((item) => item.id == friendData[index].id)
      //     .single
      //     .lastMessage = MessageModel(
      //   message: messageController.text,
      //   id: FirebaseAuth.instance.currentUser!.uid,
      // );
      messageController.clear();
      _scrollToBottom();

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
