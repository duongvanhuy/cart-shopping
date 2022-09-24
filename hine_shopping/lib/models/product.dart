import 'package:hine_shopping/models/category.dart';

class Product {
  int? id;
  String? title;
  int? price;
  String? description;
  Category? category;
  List<String>? images;

  // contractor
  Product(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.images});

  // function fromJson
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: Category.fromJson(json['category']),
        images: json['images'].cast<String>());
  }
}
