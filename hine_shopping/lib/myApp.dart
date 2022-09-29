import 'package:flutter/material.dart';
import 'package:hine_shopping/utils/cart_provider.dart';
import 'package:hine_shopping/utils/product_helper.dart';
import 'package:hine_shopping/view/account/loginView.dart';
import 'package:hine_shopping/view/product_home.dart';
//import 'package:hine_shopping/view/clothers_home_view.dart';
import 'package:provider/provider.dart';
//import 'package:hine_shopping/view/clothers_home_view.dart';

class MyApp extends StatelessWidget {
  // contractor
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductHelper()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // remove banner debug
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          // body: Text("aaaaaaaauuu"),
          body: LoginView(),
        ),
      ),
    );
  }
}
