import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createNewChat(Map<String, dynamic> chats, String docId) async {
    try {
      await _db.collection('Chats').doc(docId).set(chats);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendFirstMessage(
      String chatId, Map<String, dynamic> chat) async {
    try {
      await _db
          .collection('Chats')
          .doc(chatId)
          .collection('Messages')
          .add(chat);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendMessages(Map<String, dynamic> chats, String chatId,
      Map<String, dynamic> lastMessage) async {
    try {
      await _db
          .collection('Chats')
          .doc(chatId)
          .collection('Messages')
          .add(chats);
      await _db
          .collection('Chats')
          .doc(chatId)
          .update({'LastMessage': lastMessage});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      final messages = await _db
          .collection('Chats')
          .doc(chatId)
          .collection('Messages')
          .get();
      for (final message in messages.docs) {
        await message.reference.delete();
      }

      await _db.collection('Chats').doc(chatId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> getMessages(String chatId) {
    try {
      print(chatId);
      final data = _db
          .collection('Chats')
          .doc(chatId)
          .collection('Messages')
          .orderBy('SendAt', descending: false)
          .snapshots();
      // print(data)
      data.forEach((item) => print(item.docs.length));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> getMessagedFreind(String id) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('Chats')
          .where('UsersId', arrayContains: id)
          .orderBy('LastMessage.SendAt', descending: true)
          .get();
      // print(querySnapshot.forEach((item) => print(item.docs.length)));
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }
}
