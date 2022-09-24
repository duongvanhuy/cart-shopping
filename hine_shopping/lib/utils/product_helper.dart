import 'package:hine_shopping/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClotherHelper extends ChangeNotifier {
  List<Product> list = [];
  void getClothers() async {
    var response = await http
        .get(Uri.parse('https://api.escuelajs.co/api/v1/products'), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // final news = data['articles'];
      final news = data;
      list = news.map<Product>((json) => Product.fromJson(json)).toList();
      // alway reload when changed data
      notifyListeners();
    } else {
      throw Exception('Failed to load products');
    }
  }
}