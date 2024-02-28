// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:knm_masjid_app/constants/Theme.dart';

import 'package:login_widget/login_widget.dart';
import 'package:simple_snackbar/simple_snackbar.dart';

//widgets

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _genericValidator(String? input) {
    if (input == null) {
      return 'Invalid';
    } else if (input == '') {
      return 'Cannot be empty';
    } else if (input.length > 256) {
      return 'Too long';
    }
    return null;
  }

  @override
  void initState() {
    _usernameController.text = 'knmadmin';
    _passwordController.text = '12345678';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = MyColors.initial;

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
            decoration: BoxDecoration(
                color: Color.fromRGBO(245, 245, 245, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "KNM",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                Text("Masjid Management System",
                    style: TextStyle(color: textColor)),
                SizedBox(height: 60),
                Form(
                    child: Column(children: [
                  TextFormField(
                    style: TextStyle(color: textColor),
                    controller: _usernameController,
                    cursorColor: textColor,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: textColor),
                      border: OutlineInputBorder(),
                    ),
                    validator: _genericValidator,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    style: TextStyle(color: textColor),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hoverColor: MyColors.white,
                      labelStyle: TextStyle(color: textColor),
                      border: OutlineInputBorder(),
                    ),
                    validator: _genericValidator,
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot Password?",
                          style: TextStyle(color: textColor)),
                    ],
                  ),
                  SizedBox(height: 20),
                ])),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: MyColors.initial,
                      fixedSize: Size(double.maxFinite, 50),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {
                    // final snackBar = simpleSnackBar(
                    //     buildContext: context,
                    //     messageText: "Logging You In",
                    //     backgroundColor: Colors.white,
                    //     displayDismiss: true,
                    //     textColor: Colors.black,
                    //     snackBarType: SnackBarType.success);
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Text("Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: MyColors.muted),
                    ),
                    Text(
                      " Register here",
                      style: TextStyle(color: textColor),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
