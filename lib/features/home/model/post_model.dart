import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_app/features/home/model/comment_model.dart';

class PostModel {
  String postText;
  String imagePath;
  final String videoPath;
  final String userId;
  final String fullName;
  List likes;
  final List comments;
  final String time;
  final String? postId;

  PostModel({
    this.postId,
    required this.time,
    required this.likes,
    required this.comments,
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
      'Likes': likes,
      'Comments': comments.map((value) => value.toJson()).toList(),
      'Time': time,
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
      likes: data['Likes'] ?? 0,
      comments: data['Comments']
          .map((value) => CommentModel.fromSnapshot(value))
          .toList(),
      time: data['Time'] ?? '',
      postId: document.id,
    );
  }
}
// [this.postId ]