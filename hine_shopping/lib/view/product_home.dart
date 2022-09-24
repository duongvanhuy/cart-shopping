import 'package:hine_shopping/models/product.dart';
import 'package:hine_shopping/utils/product_helper.dart';
import 'package:flutter/material.dart';
import 'package:hine_shopping/view/cart_screen.dart';
import 'package:provider/provider.dart';

class ProductHomeView extends StatefulWidget {
  ProductHomeView({Key? key}) : super(key: key);

  @override
  State<ProductHomeView> createState() => _ProductHomeView();
}

class _ProductHomeView extends State<ProductHomeView> {
  // _controllerSearch
  final TextEditingController _controllerSearch = TextEditingController();
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ClotherHelper>(context);
    provider.getClothers();
    // controller search
    final TextEditingController _controllerSearch = TextEditingController();

    return Scaffold(
      appBar: appBar(),
      body: buildBody(provider),
    );
  }

  Widget buildBody(var provider) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        SizedBox(height: 5),
        searchProduct(),
        SizedBox(height: 7),
        buildbodyTop(),
        listCardProduct(provider),
      ],
    );
  }

  Widget buildbodyTop() {
    return Row(
      children: [
        Expanded(
          child: Text("Tóp sản phẩm bán chạy"),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text("Xem tất cả"),
            ),
          ),
        )
      ],
    );
  }

  Widget searchProduct() {
    return Container(
      // padding: const EdgeInsets.all(10),

      child: Row(
        children: [
          Expanded(
              child: SizedBox(
            height: 45,
            child: TextField(
              style:
                  TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black),
              // set height

              controller: _controllerSearch,
              decoration: InputDecoration(
                hintText: "Tìm kiếm sản phẩm",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget listCardProduct(provider) {
    return Container(
      // get height screen device
      height: MediaQuery.of(context).size.height,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6, // set height
        ),
        // primary: false,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          ...provider.list.map(
            (e) => Card(
              child: Container(
                //height: 300,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: 120,
                      child: Image(
                        image: NetworkImage(
                          e.category.image ?? '',
                          // set style image
                          scale: 1,
                        ),
                        // set style image
                      ),
                    ),
                    Text(
                      e.title ?? '',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    //  Text(e.price.toString() ??),
                    //Text(e.description ?? ''),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      e.category.name ?? '',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          // chữ in nghiêng
                          fontStyle: FontStyle.italic),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              (e.price.toString()).padRight(1) + "\$",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color.fromARGB(255, 50, 55, 84),
                            ),
                            child: IconButton(
                              // padding: const EdgeInsets.all(-1),
                              onPressed: () {},
                              icon: const Icon(
                                // Icons.favorite_border,
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //1
  appBar() {
    return AppBar(
      // back and card
      title: Container(
        width: 100,
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {},
                child: Row(children: [
                  const Icon(Icons.arrow_back),
                  Text("Quay lại".padLeft(10))
                ]),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen(products)),
            );
          },
          icon: const Icon(Icons.shopify_sharp),
          color: Colors.brown,
          iconSize: 30,
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
