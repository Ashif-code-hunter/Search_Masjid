import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Lottie.asset('assets/lottie/loading.json'),
                ),
              ],
            ),
          ],
        ),
      )
    ]));
  }
}
