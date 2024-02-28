// ignore_for_file: unnecessary_new, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:knm_masjid_app/screens/beauty.dart';
import 'package:knm_masjid_app/screens/login.dart';

// screens
import 'package:knm_masjid_app/screens/onboarding.dart';
import 'package:knm_masjid_app/screens/home.dart';
import 'package:knm_masjid_app/screens/profile.dart';
import 'package:knm_masjid_app/screens/settings.dart';
import 'package:knm_masjid_app/screens/register.dart';
import 'package:knm_masjid_app/screens/notifications.dart';
import 'package:knm_masjid_app/screens/articles.dart';
import 'package:knm_masjid_app/screens/elements.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'KNM Masjid Management',
        theme: ThemeData(fontFamily: 'OpenSans'),
        initialRoute: "/login",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/onboarding": (BuildContext context) => new Onboarding(),
          "/login": (BuildContext context) => new Login(),
          "/register": (BuildContext context) => new Register(),
          "/home": (BuildContext context) => new Home(),
          "/profile": (BuildContext context) => new Profile(),
          "/settings": (BuildContext context) => new Settings(),
          "/articles": (BuildContext context) => new Articles(),
          "/elements": (BuildContext context) => new Elements(),
          "/account": (BuildContext context) => new Register(),
          "/notifications": (BuildContext context) => new Notifications(),
        });
  }
}
