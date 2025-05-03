class CommentModel {
  final String fullName;
  final String commentText;
  List likes;
  final String userId;
  List comments;

  CommentModel(
      {required this.fullName,
      required this.commentText,
      required this.likes,
      required this.userId,
      required this.comments});

  Map<String, dynamic> toJson() {
    return {
      'FullName': fullName,
      'CommentText': commentText,
      'Likes': likes,
      'UserId': userId,
      'Comments': comments.map((value) => value.toJson()),
    };
  }

  factory CommentModel.fromSnapshot(Map<String, dynamic> document) {
    final data = document;
    return CommentModel(
      fullName: data['FullName'] ?? '',
      commentText: data['CommentText'] ?? '',
      likes: data['Likes'] ?? '',
      userId: data['UserId'] ?? '',
      comments: data['Comments'] != []
          ? data['Comments']
              .map((value) => CommentModel.fromSnapshot(value))
              .toList()
          : [],
    );
  }
}
