import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/home/model/post_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostRepository extends GetxController {
  final _db = FirebaseFirestore.instance;

  Future<String> postImage(String path, XFile file) async {
    try {
      final image = Supabase.instance.client;
      final result =
          await image.storage.from('ImagePost').upload(path, File(file.path));
      final url = image.storage.from('ImagePost').getPublicUrl(path);
      return url;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postAll(PostModel post) async {
    try {
      await _db.collection('Posts').add(post.toJson());
    } catch (e) {
      rethrow;
    }
  }

  DocumentSnapshot? lastDocument;

  Future<List<PostModel>> getInitialPosts() async {
    try {
      final post = await _db.collection('Posts').limit(10).get();
      final docs = post.docs;
      lastDocument = docs.last;
      print(lastDocument);
      final data = docs.map((value) => PostModel.fromSnapshot(value)).toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PostModel>> fetchMoreData() async {
    try {
      final snapshot = await _db
          .collection('Posts')
          .startAfterDocument(lastDocument!)
          .limit(10)
          .get();
      final newDocuments = snapshot.docs;
      lastDocument = newDocuments.last;
      final data =
          newDocuments.map((value) => PostModel.fromSnapshot(value)).toList();

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
