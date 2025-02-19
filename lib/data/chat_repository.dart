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

  Future<void> sendMessages(Map<String, dynamic> lastMessage,
      Map<String, dynamic> chats, String chatId) async {
    try {
      await _db
          .collection('Chats')
          .doc(chatId)
          .update({'LastMessage': lastMessage});
      await _db
          .collection('Chats')
          .doc(chatId)
          .collection('Messages')
          .add(chats);
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> getMessages(List<Map<String, dynamic>> values) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('Chats')
          .where('Id', arrayContains: values)
          .get();
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> getMessagedFreind(String id) {
    try {
      Stream<QuerySnapshot> querySnapshot = _db
          .collection('Chats')
          .where('UsersId', arrayContains: id)
          .orderBy('LastMessage.SendAt', descending: true)
          .snapshots();
      print(querySnapshot.first.toString());
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }
}
