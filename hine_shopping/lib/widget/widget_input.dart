import 'package:flutter/material.dart';
import 'package:hine_shopping/configs/setting.dart';
import 'package:validators/validators.dart';

class WidgetInput extends StatefulWidget {
  late String name;
  IconData? icon;
  dynamic controller;
  bool? isPassword;
  String? password; // áp dụng đối với input nhập lại mật khẩu
  String? valueState; // thuộc tính của một đối tượng nào đó ta muốn set
  WidgetInput(this.controller, this.name, this.icon, this.isPassword,
      this.valueState, this.password);
  WidgetInput.TextFiledName(this.name, this.controller, this.icon);

  @override
  State<WidgetInput> createState() => _WidgetInputState(
      controller, name, icon, isPassword, valueState, password);
}

class _WidgetInputState extends State<WidgetInput> {
  String name;
  IconData? icon;
  dynamic controller;
  bool? isPassword;
  String? password;
  String? valueState;
  _WidgetInputState(this.controller, this.name, this.icon, this.isPassword,
      this.valueState, this.password);
  String validate(value, String? comparePassword) {
    // switch case để kiểm tra các trường hợp
    switch (name) {
      case Setting.inpName:
        if (value.isEmpty || value == null || value == '') {
          return Setting.formName;
        }

        break;
      case Setting.inpPassword:
        if (value.isEmpty) {
          return Setting.formPassWord;
        } else if (value.length < 6) {
          return Setting.formPassWordValid;
        }
        break;
      case Setting.inpConfirmPassword:
        if (value.isEmpty) {
          return Setting.formPassWord;
        } else if (value.length < 6) {
          return Setting.formPassWordValid;
        } else if (value != password) {
          return Setting.formPassWordCompare;
        }
        break;
      case Setting.inpEmail:
        if (value.isEmpty) {
          return Setting.formEmail;
        } else if (!isEmail(value)) {
          return Setting.formEmailValid;
        }
        break;
      case Setting.inpSearch:
        if (value.isEmpty) {
          return Setting.formSearch;
        }
        break;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      //  height: 50,
      child: TextFormField(
        obscureText: isPassword != null || isPassword == true ? true : false,
        // maxLines: 3,
        // minLines: 1,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            labelText: name,
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue))),
        // validator: (value) {
        //   validate(value, password);
        //   // return null;
        // },

        validator: (value) {
          String message = validate(value, password);
          if (message != '') {
            return message;
          }
          return null;
        },

        onChanged: (value) {
          setState(() {
            valueState = value;
          });
        },
      ),
    );
  }
}
