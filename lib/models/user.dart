class User {
  int? id;
  String? name;
  String? email;
  String? location;
  String? token;
  String? role;

  User({
    this.id,
    this.name,
    this.email,
    this.location,
    this.role,
    this.token,
  });

  User.fromJson(Map<String, dynamic> json, String type) {
    if (type == "login") {
      name = json['user']['name'];
      email = json['user']['email'];
      location = json['user']['location'];
      id = json['user']['id'];
      token = json['token'];
      role = json['user']['role'];
    } else {
      name = json['name'];
      email = json['email'];
      location = json['location'];
      id = json['id'];
      role = json['roles'];
    }
  }
}
