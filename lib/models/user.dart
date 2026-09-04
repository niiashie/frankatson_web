import 'package:frankoweb/utils/json_parse.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? location;
  String? token;
  String? role;
  int? roleId;
  String? image;
  List<String>? permissions;

  User({
    this.id,
    this.name,
    this.email,
    this.location,
    this.role,
    this.token,
    this.roleId,
    this.image,
    this.permissions,
  });

  User.fromJson(Map<String, dynamic> json, String type) {
    if (type == "login") {
      id = asInt(json['user']['id']);
      name = json['user']['name'];
      email = json['user']['email'];
      location = json['user']['location'];
      roleId = asInt(json['user']['role_id']);
      image = json['user']['image'];
      token = json['token'];
      final roleObj = json['user']['role'];
      role = roleObj?['name'];
      permissions = roleObj != null
          ? List<String>.from(roleObj['permissions'] ?? [])
          : [];
    } else {
      id = asInt(json['id']);
      name = json['name'];
      email = json['email'];
      location = json['location'];
      role = json['roles'];
    }
  }
}
