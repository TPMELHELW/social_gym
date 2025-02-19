// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gym_app/data/chat_repository.dart';
// import 'package:gym_app/features/chat/model/chat_model.dart';

// class ChattingController extends GetxController {
//   final ChatRepository chatRepository = Get.put(ChatRepository());
//   List chats = [];
//   late TextEditingController messageController;

//   Future<void> sendMessage(recivedId) async {
//     try {
//       if (chats.isEmpty) {
//         final ChatModel chats = ChatModel(
//           senderId: FirebaseAuth.instance.currentUser!.uid,
//           recivedId: recivedId,
//           chats: [
//             {
//               'Message': messageController.text,
//               'id': FirebaseAuth.instance.currentUser!.uid
//             }
//           ],
//         );
//         await chatRepository.sendFirstMessage(chats.toJson());
//         print('success');
//       }
//     } catch (e) {}
//   }

//   @override
//   void onInit() {
//     messageController = TextEditingController();
//     super.onInit();
//   }
// }
