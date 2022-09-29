import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hine_shopping/utils/product_helper.dart';
import 'package:hine_shopping/view/product_home.dart';
import 'package:hine_shopping/widget/account/icon_bottom.dart';
import 'registerView.dart';
import 'package:hine_shopping/widget/widget_input.dart';
import 'package:hine_shopping/configs/setting.dart';
import 'package:hine_shopping/widget/widget_input.dart';

class LoginView extends StatefulWidget {
  // contractor
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // kết hợp với text field để lấy dữ liệu của text filed đó
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isRemember = false;

  // create object user
  // User user = User(username: '', password: '', email: '');
  // xác định duy nhất form này dc validate- lưu lại trạng thái trong form
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductHelper>(context);
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg-login.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: buildBody(provider),
      ),
    );
  }

  Widget buildBody(provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //  border icon user
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ]),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.blue,
              ),
            ),
          ),
          // margin bottom
          const SizedBox(
            height: 20,
          ),
          contentLogin(provider),
          const SizedBox(height: 20),
          // register
          // register()
          buildBottom(),
        ],
      ),
    );
  }

  Widget register() {
    return Center(
      child: Container(
        width: 300,
        // alighnment center

        padding: EdgeInsets.only(top: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: const [
                  Text("Chưa có tài khoản?"),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  goToRegister(),
                ],
              )
            ]),
      ),
    );
  }

  Widget goToRegister() {
    // lắng nghe sự kiện click -- tương tự như button
    return TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RegisterView()));
      },
      child: const Text('Đăng kí',
          style: TextStyle(fontSize: 16, color: Colors.greenAccent)),
    );
  }

  void goToHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductHomeView()));
  }

  Widget contentLogin(provider) {
    // return form login
    return Form(
      key: _formKey,
      child: Column(
        children: [
          WidgetInput(
            _usernameController,
            Setting.inpName,
            Icons.person,
            null,
            'Huy',
            null,
          ),
          // padding bottom
          const SizedBox(height: 20),
          // container for password
          WidgetInput(
            _passwordController,
            Setting.inpPassword,
            Icons.lock,
            true,
            "12345678",
            null,
          ),
          const SizedBox(height: 20),

          // check box remember me
          Container(
            width: 300,
            child: Row(
              children: [
                Checkbox(
                  value: _isRemember,
                  onChanged: (value) {
                    setState(() {
                      // value is true or false
                      _isRemember = value!;
                    });
                  },
                ),
                const Text(
                  'Ghi nhớ đăng nhập',
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      forgotPassword();
                    },
                    child: const Text(
                      'Quên mật khẩu?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          // login button
          ElevatedButton(
            onPressed: () async {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // delete data in text field
                // _usernameController.clear();
                //   goToHome();
                var check = await ProductHelper()
                    .auth(_usernameController.text, _passwordController.text);

                if (check) {
                  goToHome();
                } else {
                  // alert
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Thông báo'),
                          content: const Text('Đăng nhập thất bại'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'))
                          ],
                        );
                      });
                }
              }
            },
            style: ElevatedButton.styleFrom(
              //   primary: Colors.black,
              minimumSize: const Size(310, 55),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Đăng nhập'),
          ),
        ],
      ),
    );
  }

  Widget buildBottom() {
    return Container(
      height: 100,
      // width: double.infinity,
      // color: Colors.blue,
      child: Column(
        children: [
          IconBottom(),
          register(),
        ],
      ),
    );
  }

  // quên mật khẩu
  void forgotPassword() {
    // show dialog
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Quên mật khẩu'),
            content: Container(
              height: 100,
              child: Column(
                children: [
                  const Text('Vui lòng nhập email để lấy lại mật khẩu'),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // 2 cách viết
                  //    Navigator.pop(context);
                  Navigator.of(context).pop();
                },
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Gửi'),
              ),
            ],
          );
        });
  }
}
