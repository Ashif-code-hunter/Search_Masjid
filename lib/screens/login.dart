import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/controller/auth.controller.dart';

//widgets

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final authC = Get.put(AuthController());

  final _emailController = TextEditingController();
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

  void _login() async {
    String username = _emailController.text;
    String password = _passwordController.text;
    bool isLogged = await authC.login(username, password);
    if (isLogged) {
      Get.offAllNamed('/home');
      return;
    }
    Get.snackbar("Error", "Invalid username or password");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color textColor = MyColors.initial;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        leading: BackButton(color: textColor, onPressed: () => Get.back()),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(245, 245, 245, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Masjid Login",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                const Text("Masjid Management System",
                    style: TextStyle(color: textColor)),
                const SizedBox(height: 60),
                Form(
                    child: Column(children: [
                  TextFormField(
                    style: const TextStyle(color: textColor),
                    controller: _emailController,
                    cursorColor: textColor,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: textColor),
                      border: OutlineInputBorder(),
                    ),
                    validator: _genericValidator,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    style: const TextStyle(color: textColor),
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hoverColor: MyColors.white,
                      labelStyle: TextStyle(color: textColor),
                      border: OutlineInputBorder(),
                    ),
                    validator: _genericValidator,
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot Password?",
                          style: TextStyle(color: textColor)),
                    ],
                  ),
                  const SizedBox(height: 20),
                ])),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {
                    _login();
                  },
                  child: const Text("Login",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 5),
                const Row(
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
