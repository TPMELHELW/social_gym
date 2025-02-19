import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/home/model/post_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostRepository extends GetxController {
  final _db = FirebaseFirestore.instance.collection('Posts');

  Future<String> postImage(String path, XFile file) async {
    try {
      final image = Supabase.instance.client;

      await image.storage.from('ImagePost').upload(path, File(file.path));
      final url = image.storage.from('ImagePost').getPublicUrl(path);
      return url;
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> postAll(
      PostModel post) async {
    try {
      final data = await _db.add(post.toJson());
      return data;
    } catch (e) {
      rethrow;
    }
  }

  DocumentSnapshot? lastDocument;

  Future<QuerySnapshot> getAllPosts() async {
    try {
      QuerySnapshot snapshot;
      if (lastDocument == null) {
        snapshot = await _db.limit(10).get();
        lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

        return snapshot;
      } else {
        snapshot = await _db.startAfterDocument(lastDocument!).limit(10).get();
        lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
        return snapshot;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postUpdate(id, data) async {
    try {
      await _db.doc(id).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(id) async {
    try {
      await _db.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> addComment ()
}
