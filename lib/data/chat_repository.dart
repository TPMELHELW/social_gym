import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendFirstMessage(Map<String, dynamic> chats) async {
    try {
      // print('enter');
      await _db.collection('Chats').add(chats);
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  Future<void> sendMessages(
      List<String> values, Map<String, dynamic> chats) async {
    try {
      final data = await _db
          .collection('Chats')
          .where('Id', arrayContainsAny: values)
          .get();
      List document = data.docs.first.get('Messages');
      document.add(chats);
      await data.docs.first.reference.update({'Messages': document});
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> getMessages(List<String> values) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('Chats')
          .where('Id', arrayContainsAny: values)
          .get();
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }
}
