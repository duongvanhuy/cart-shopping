import 'package:flutter/material.dart';
import 'package:hine_shopping/models/product.dart';
import 'package:hine_shopping/utils/product_helper.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  List<Product>? _listCart;
  CartScreen(listCart) {
    _listCart = listCart;
  }

  @override
  State<CartScreen> createState() => _CartScreenState(_listCart);
}

class _CartScreenState extends State<CartScreen> {
  List<Product>? _listCart;
  _CartScreenState(listCart) {
    _listCart = listCart;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Giỏ hàng"),
        ),
        body: buildBody());
  }

  Widget buildBody() {
    return Consumer<ProductHelper>(builder: (context, value, child) {
      return Container(
          child: ListView(
              padding: const EdgeInsets.all(10),
              scrollDirection: Axis.vertical,
              children: [
            for (var item in _listCart!)
              Container(
                child: ListTile(
                    leading: Container(
                      child: Checkbox(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),
                    title: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Image(
                            image: NetworkImage(
                              item.category!.image!,
                              // set style image
                              scale: 1,
                            ),
                          ),
                        ),
                        Text(
                          item.title!,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.price.toString() + "\$",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // thêm - xóa số lượng sản phẩm "-; +" trong giỏ hàng
                          Row(
                            children: [
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    value.changeCounter(0);
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                              ),
                              Text("${value.counter}"),
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    value.changeCounter(1);
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ])

                    //   trailing: Text("Số lượng"),
                    ),
              )
          ]));
    });
  }
}
