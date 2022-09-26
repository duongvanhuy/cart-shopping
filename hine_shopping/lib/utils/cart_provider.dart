import 'package:flutter/cupertino.dart';
import 'package:hine_shopping/database/db_helper.dart';
import 'package:hine_shopping/models/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  DBHelper dbHelper = DBHelper();
  int _counter = 1;
  int _quantity = 1;
  int get counter => _counter;
  int get quantity => _quantity;
  int totalProductInCart = 0;
  double totalPrice = 0.0;
  // double get totalPrice => _totalPrice;
  bool checkAll = false;
  List<bool> checkList = []; // lưu lại các check list từng sản phẩm trong cart

  List<Cart> carts = [];
  changeCounter(int value, int id) {
    int check = carts.indexWhere((e) => e.id == id);
    if (check >= 0) {
      if (value > 0) {
        carts[check].quantity!.value++;
        setPriceInCart();
      } else if (carts[check].quantity!.value > 1) {
        carts[check].quantity!.value--;
        setPriceInCart();
      }
    }
    notifyListeners();
  }

  void checkAllCart(bool value) {
    checkAll = checkAll ? false : true;
    if (checkAll) {
      checkList = checkList.map((e) => true).toList();
      getTotalPrice();
    } else {
      checkList = checkList.map((e) => false).toList();
      totalPrice = 0.0;
    }
    notifyListeners();
  }

  void checkCart(int id) {
    int check = carts.indexWhere((e) => e.id == id);
    if (check >= 0) {
      checkList[check] = checkList[check] ? false : true;
      bool countCheck =
          checkList.where((e) => e == true).toList().length == checkList.length;
      if (countCheck) {
        checkAll = true;
      } else {
        checkAll = false;
      }
    }
    setPriceInCart();
    notifyListeners();
  }

  void setPriceInCart() {
    totalPrice = 0.0;
    checkList.forEach((e) {
      if (e) {
        totalPrice += carts[checkList.indexOf(e)].productPrice! *
            carts[checkList.indexOf(e)].quantity!.value;
      }
    });
    notifyListeners();
  }

  Future<List<Cart>> getData() async {
    carts = await dbHelper.getCartList();
    notifyListeners();
    return carts;
  }

  void insertDataToCart(Cart cartData) {
    int check = carts.indexWhere((e) => e.id == cartData.id);
    if (check >= 0) {
      carts[check].quantity!.value++;
    } else {
      carts.add(cartData);
      checkList.add(false);
    }
    notifyListeners();
  }

  void getTotalPrice() {
    for (var i = 0; i < carts.length; i++) {
      totalPrice += carts[i].productPrice! * carts[i].quantity!.value;
    }
  }

  void _setPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', _counter);
    prefs.setInt('item_quantity', _quantity);
    prefs.setDouble('total_price', totalPrice);
    notifyListeners();
  }

  void _getPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_items') ?? 0;
    _quantity = prefs.getInt('item_quantity') ?? 1;
    totalPrice = prefs.getDouble('total_price') ?? 0;
  }

  void addCounter() {
    _counter++;
    _setPrefsItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefsItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefsItems();
    return _counter;
  }

  void addQuantity(int id) {
    final index = carts.indexWhere((element) => element.id == id);
    carts[index].quantity!.value = carts[index].quantity!.value + 1;
    _setPrefsItems();
    notifyListeners();
  }

  void deleteQuantity(int id) {
    final index = carts.indexWhere((element) => element.id == id);
    final currentQuantity = carts[index].quantity!.value;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      carts[index].quantity!.value = currentQuantity - 1;
    }
    _setPrefsItems();
    notifyListeners();
  }

  void removeItem(int id) {
    final index = carts.indexWhere((element) => element.id == id);
    carts.removeAt(index);
    _setPrefsItems();
    notifyListeners();
  }

  int getQuantity(int quantity) {
    _getPrefsItems();
    return _quantity;
  }

  void addTotalPrice(double productPrice) {
    totalPrice = totalPrice + productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    totalPrice = totalPrice - productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  // double getTotalPrice() {
  //   _getPrefsItems();
  //   return _totalPrice;
  // }
}
