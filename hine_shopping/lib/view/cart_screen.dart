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
  // check  "_isChecked"
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
      ),
      body: buildBody(),
      bottomNavigationBar: buildBottom(),
    );
  }

  Widget buildBody() {
    return Consumer<ProductHelper>(builder: (context, value, child) {
      return Container(
          child: ListView(
              // padding: const EdgeInsets.all(10),
              scrollDirection: Axis.vertical,
              children: [
            address(),
            checkAllProduct(),
            SizedBox(height: 7),
            for (var item in _listCart!)
              Container(
                padding: const EdgeInsets.all(10),
                // border bottom
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(children: [
                  Container(
                    child: Checkbox(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Image.network(item.category!.image!,
                            height: 100, width: 80, fit: BoxFit.cover),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title!,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            item.price.toString() + "\.000 đ",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // thêm - xóa số lượng sản phẩm "-; +" trong giỏ hàng
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // padding left :0
                                // padding: EdgeInsets.only(left: 0),

                                child: IconButton(
                                  onPressed: () {
                                    value.changeCounter(0);
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                              ),
                              Container(
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //   color: Colors.grey.shade400,
                                  //   width: 1,
                                  // )),
                                  child: Text("${value.counter}")),
                              Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(
                                //   color: Colors.grey.shade400,
                                //   width: 1,
                                // )),
                                child: IconButton(
                                  onPressed: () {
                                    value.changeCounter(1);
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Xóa",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  //   trailing: Text("Số lượng"),
                ]),
              )
          ]));
    });
  }

  Widget address() {
    return Container(
      //width: double.infinity,
      padding: const EdgeInsets.all(10),
      // border bottom
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey.shade200,
        width: 6,
      ))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on, color: Colors.blue),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text("Phường An Cựu, Thành phố Huế, Thừa Thiên Huế",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            Icon(Icons.navigate_next, color: Colors.blue),
          ]),
    );
  }

  Widget buildBottom() {
    return Container(
      // border top
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
        color: Colors.grey.shade200,
        width: 1,
      ))),
      height: 100,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            // border bottom
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ))),
            child: Row(
              children: [
                // icon khuyến mãi
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(Icons.card_giftcard),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: Text("Hine Fahasa khuyến mãi")),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "Nhập hoặc chọn mã",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.end,
                  ),
                )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "Tổng tiền: 0 \$",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Thanh toán"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(32.0),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // tất cả sanr phẩm

  Widget checkAllProduct() {
    return Container(
      padding: const EdgeInsets.all(10),
      // border bottom
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey.shade200,
        width: 1,
      ))),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value!;
              });
            },
          ),
          Text("Tất cả sản phẩm"),
          // Icon thùng rác
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(left: 10),
              child: Icon(Icons.delete_outline),
            ),
          ),
        ],
      ),
    );
  }
}
