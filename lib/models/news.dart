import 'package:frankoweb/models/user.dart';

class News {
  int? id;
  String? title;
  String? description;
  String? content;
  String? image;
  User? user;
  DateTime? date;

  News(
      {this.id,
      this.title,
      this.description,
      this.content,
      this.image,
      this.user,
      this.date});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
    image = json['image'];
    date = DateTime.parse(json['created_at']);
    user = User.fromJson(json['user'], "");
  }
}
