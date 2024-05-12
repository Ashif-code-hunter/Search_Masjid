// ignore_for_file: unnecessary_new, use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knm_masjid_app/controller/auth.controller.dart';
import 'package:knm_masjid_app/controller/fav.controller.dart';
import 'package:knm_masjid_app/controller/masjid.controller.dart';
import 'package:knm_masjid_app/firebase_options.dart';
import 'package:knm_masjid_app/screens/announcements.dart';
import 'package:knm_masjid_app/screens/detailmasjid.dart';
import 'package:knm_masjid_app/screens/favorites.dart';
import 'package:knm_masjid_app/screens/login.dart';
import 'package:knm_masjid_app/screens/notify.dart';
// screens
import 'package:knm_masjid_app/screens/onboarding.dart';
import 'package:knm_masjid_app/screens/home.dart';
import 'package:knm_masjid_app/screens/profile.dart';
import 'package:knm_masjid_app/screens/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'KNM Masjid Management',
        initialRoute: "/home",
        debugShowCheckedModeBanner: false,
        initialBinding: BindingsBuilder(() {
          Get.put(AuthController(), permanent: true);
          Get.put(FavoriteController(), permanent: true);
          Get.put(MasjidController(), permanent: true);          
        }),
        getPages: [
          GetPage(name: '/onboarding', page: () => const Onboarding()),
          GetPage(name: '/profile', page: () => Profile()),
          GetPage(name: '/login', page: () => const Login()),
          GetPage(name: '/home', page: () => const Home()),
          GetPage(name: '/detailmasjid', page: () => DetailMasjid()),
          GetPage(name: '/announcements', page: () => const Announcements()),
          GetPage(name: '/favorites', page: () => const Favorites(), binding: BindingsBuilder(() {
          })),
          GetPage(name: '/notify', page: () => const Notify()),
          GetPage(name: '/notifications', page: () => Notifications())
        ],
        
        );
  }
}
