import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/data/chat_repository.dart';
import 'package:gym_app/data/user_repository.dart';
import 'package:gym_app/features/auth/model/user_model.dart';
import 'package:gym_app/features/chat/model/chat_model.dart';
import 'package:gym_app/features/chat/model/message_model.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find<ChatController>();

  final UserRepository userRepository = Get.find<UserRepository>();
  final ChatRepository chatRepository = Get.put(ChatRepository());
  late TextEditingController messageController;

  late UserModel currentUser;
  final box = GetStorage();

  List<UserModel> userData = [];
  List<MessageModel> chats = [];

  DateTime now = DateTime.now();

  // final lastSeen = now.subtract(currentUser.lastSeen.);

  Future<void> fetchDocuments() async {
    try {
      final QuerySnapshot querySnapshot =
          await userRepository.getSpecialUsers(currentUser.friendList);
      for (var doc in querySnapshot.docs) {
        userData.add(UserModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>));
      }
      update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  String getLastSeen(int index) {
    DateTime lastSeenTimestamp = userData[index].lastSeen.toDate();
    print(currentUser.lastSeen);
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

  Future<void> getChats(int index) async {
    // currentUser.lastSeen.compareTo(now.day);
    try {
      final data = await chatRepository.getMessages(
        [
          userData[index].id,
          FirebaseAuth.instance.currentUser!.uid,
        ],
      );
      final List gg = data.docs[0]['Messages'];
      // print(gg);
      final List<MessageModel> mm =
          gg.map((value) => MessageModel.fromSnapshot(value)).toList();
      print(mm[0].message);

      chats = mm;
      // print(chats);
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  Future<void> sendMessage(int index) async {
    try {
      // chats.clear();
      if (chats.isEmpty) {
        final ChatModel chats = ChatModel(
          messages: [
            MessageModel(
              message: messageController.text,
              id: FirebaseAuth.instance.currentUser!.uid,
            ),
          ],
          id: [
            FirebaseAuth.instance.currentUser!.uid,
            userData[index].id,
          ],
        );
        await chatRepository.sendFirstMessage(chats.toJson());
        return;
      }

      await chatRepository.sendMessages([
        userData[index].id,
        FirebaseAuth.instance.currentUser!.uid,
      ], {
        'Message': messageController.text,
        'Id': FirebaseAuth.instance.currentUser!.uid
      });
      print('success');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    currentUser = UserModel.fromStorage(box.read('UserData'));
    fetchDocuments();
    messageController = TextEditingController();
    super.onInit();
  }
}
