class Gallery {
  int? id;
  String? image;
  DateTime? date;

  Gallery({this.id, this.image, this.date});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    date = DateTime.parse(json['created_at']);
  }
}
