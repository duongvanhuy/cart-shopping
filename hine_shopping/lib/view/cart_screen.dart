import 'package:flutter/material.dart';
import 'package:hine_shopping/models/cart.dart';
import 'package:hine_shopping/models/product.dart';
import 'package:hine_shopping/utils/cart_provider.dart';
import 'package:hine_shopping/utils/product_helper.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isChecked = false;
  CartProvider? props;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Giỏ hàng"),
        ),
        body: buildBody(value),
        bottomNavigationBar: buildBottom(value),
      );
    });
  }

  Widget buildBody(value) {
    // return Consumer<CartProvider>(builder: (context, value, child) {
    // props = value;
    print("value.carts: ${value.carts}");
    return Container(
        child: ListView(
            // padding: const EdgeInsets.all(10),
            scrollDirection: Axis.vertical,
            children: [
          address(),
          checkAllProduct(value),
          SizedBox(height: 7),
          for (var i = 0; i < value.carts!.length; i++)
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
                    value: value.checkList[i],
                    onChanged: (e) {
                      value.checkCart(value.carts![i].id!);
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Container(
                      child: Image.network(value.carts![i].image!,
                          height: 100, width: 80, fit: BoxFit.cover),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.carts![i].productName!,
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
                          value.carts![i].initialPrice.toString() + "\.000 đ",
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
                                  value.changeCounter(0, value.carts![i].id!);
                                },
                                icon: Icon(Icons.remove),
                              ),
                            ),
                            Container(
                                child:
                                    Text("${value.carts[i].quantity!.value}")),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  value.changeCounter(1, value.carts![i].id!);
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

  Widget buildBottom(value) {
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
                    "Tổng tiền: ${value.totalPrice} đ",
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

  Widget checkAllProduct(CartProvider props) {
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
            value: props.checkAll,
            onChanged: (value) {
              props.checkAllCart(props.checkAll);
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
