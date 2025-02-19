import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/features/auth/model/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;

  Future<void> saveUserInf(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } catch (e) {
      print(e);
      showErrorSnackbar('Error', e.toString());
    }
  }

  // Future<void> addUserInf(data) async {
  //   try {
  //     await _db.collection('Users').doc(auth!.uid).update(data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<UserModel> getUserData() async {
    try {
      final data = await _db.collection('Users').doc(auth!.uid).get();
      if (data.exists) {
        return UserModel.fromSnapshot(data);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateUserDetails(UserModel data) async {
    try {
      await _db.collection('Users').doc(auth!.uid).update(data.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> updateSingleUserInf(Map<String, dynamic> data) async {
    try {
      await _db.collection('Users').doc(auth!.uid).update(data);
      return await getUserData();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeUserData() async {
    try {
      await _db.collection('Users').doc(auth!.uid).delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> uploadProfileImage(String path, XFile file) async {
    try {
      final image = Supabase.instance.client;
      final result =
          await image.storage.from('Profiles').upload(path, File(file.path));
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<QuerySnapshot> getSpecialUsers(List values) async {
    try {
      // print(values);
      QuerySnapshot querySnapshot = await _db
          .collection('Users')
          .where(FieldPath.documentId, whereIn: values)
          .get();
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }

  // Future<List<QueryDocumentSnapshot>> getAllUsersData() async {
  //   try {
  //     final data = await _db.collection('Users').get();
  //     return data.docs;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
