import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postText;
  final String imagePath;
  final String videoPath;
  final String userId;
  final String fullName;

  PostModel({
    required this.postText,
    required this.imagePath,
    required this.videoPath,
    required this.userId,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'PostText': postText,
      'ImagePath': imagePath,
      'VideoPath': videoPath,
      'UserId': userId,
      'FullName': fullName,
    };
  }

  factory PostModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PostModel(
      postText: data['PostText'] ?? '',
      imagePath: data['ImagePath'] ?? '',
      videoPath: data['VideoPath'] ?? '',
      userId: data['UserId'] ?? '',
      fullName: data['FullName'] ?? '',
    );
  }
}
