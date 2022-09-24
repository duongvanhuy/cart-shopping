class Category {
  int? id;
  String? name;
  String? image;

  // contractor
  Category({this.id, this.name, this.image});

  // function fromJson
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name'], image: json['image']);
  }
}
