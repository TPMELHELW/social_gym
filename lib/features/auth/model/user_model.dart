import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String number;
  String profilePicture;
  bool isApproved;
  String plan;
  List friendList;
  String lastSeen;

  UserModel(
      {required this.id,
      required this.lastSeen,
      required this.friendList,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.number,
      required this.profilePicture,
      required this.isApproved,
      required this.plan});

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': number,
      'ProfilePicture': profilePicture,
      'isApproved': isApproved,
      'Plan': plan,
      'FriendList': friendList,
      'LastSeen': lastSeen,
    };
  }

  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        userName: '',
        email: '',
        number: '',
        profilePicture: '',
        isApproved: false,
        plan: '',
        friendList: [],
        lastSeen: '',
      );

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      userName: data['UserName'] ?? '',
      email: data['Email'] ?? '',
      number: data['PhoneNumber'] ?? '',
      profilePicture: data['ProfilePicture'] ?? '',
      isApproved: data['isApproved'] ?? false,
      plan: data['Plan'] ?? '',
      friendList: data['FriendList'] ?? [],
      lastSeen: data['LastSeen'] ?? '',
    );
  }

  factory UserModel.fromStorage(Map<String, dynamic> document) {
    // final data = document.data()!;
    //  document = json.decode(data!);
    return UserModel(
      id: FirebaseAuth.instance.currentUser!.uid,
      firstName: document['FirstName'] ?? '',
      lastName: document['LastName'] ?? '',
      userName: document['UserName'] ?? '',
      email: document['Email'] ?? '',
      number: document['PhoneNumber'] ?? '',
      profilePicture: document['ProfilePicture'] ?? '',
      isApproved: document['isApproved'] ?? false,
      plan: document['Plan'] ?? '',
      friendList: document['FriendList'] ?? [],
      lastSeen: document['LastSeen'] ?? '',
    );
  }
}
