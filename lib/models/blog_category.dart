class BlogCategory {
  int? id;
  String? name;
  String? description;
  String? image;

  BlogCategory({this.id, this.image, this.description, this.name});

  BlogCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    description = json['description'];
    name = json['name'];
  }
}
