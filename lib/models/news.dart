import 'package:frankoweb/models/user.dart';
import 'package:frankoweb/utils/json_parse.dart';

class Post {
  int? id;
  int? authorId;
  String? title;
  String? description;
  String? content;
  String? image;
  User? user;
  DateTime? date;
  DateTime? updatedAt;
  int likesCount;
  int commentsCount;

  Post({
    this.id,
    this.authorId,
    this.title,
    this.description,
    this.content,
    this.image,
    this.user,
    this.date,
    this.updatedAt,
    this.likesCount = 0,
    this.commentsCount = 0,
  });

  Post.fromJson(Map<String, dynamic> json)
      : likesCount = asIntOr(json['likes_count'], 0),
        commentsCount = asIntOr(json['comments_count'], 0) {
    id = asInt(json['id']);
    authorId = asInt(json['author_id']);
    title = json['title'];
    description = json['description'];
    content = json['content'];
    image = json['image'];
    date = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    user = json['user'] != null ? User.fromJson(json['user'], "") : null;
  }
}

class Comment {
  int? id;
  String? body;
  User? user;
  DateTime? createdAt;

  Comment.fromJson(Map<String, dynamic> json) {
    id = asInt(json['id']);
    body = json['body'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    try {
      user = User.fromJson(json['user'], "");
    } catch (_) {}
  }
}
