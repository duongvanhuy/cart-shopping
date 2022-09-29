import 'package:hine_shopping/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductHelper extends ChangeNotifier {
  int counter = 1;
  int totalProductInCart = 0;
  List<Product> list = [];
  String token = '';
  bool isLogin = false;

  changeCounter(int value) {
    if (value > 0) {
      counter = counter + 1;
    } else if (counter > 1) {
      counter = counter - 1;
    }
    notifyListeners();
  }

  changeTotalProductInCart() {}

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

  Future<bool> auth(String email, String password) async {
    var response =
        await http.post(Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{
              'email': email,
              'password': password,
            }));

    print("data input" + email + password + response.statusCode.toString());
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      token = data['access_token'];
      isLogin = true;
      print("data output" + isLogin.toString());
      notifyListeners();
      return true;
    } else {
      isLogin = false;
      notifyListeners();
      throw Exception('Failed to load products');
    }
  }
}
