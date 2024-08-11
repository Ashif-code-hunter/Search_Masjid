// ignore_for_file: unnecessary_new, use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knm_masjid_app/controller/app.controller.dart';
import 'package:knm_masjid_app/controller/auth.controller.dart';
import 'package:knm_masjid_app/controller/fav.controller.dart';
import 'package:knm_masjid_app/controller/masjid.controller.dart';
import 'package:knm_masjid_app/enum/role.dart';
import 'package:knm_masjid_app/firebase_options.dart';
import 'package:knm_masjid_app/model/push_notification_model/push_notification_model.dart';
import 'package:knm_masjid_app/screens/add_masjid.dart';
import 'package:knm_masjid_app/screens/announcements.dart';
import 'package:knm_masjid_app/screens/crash_screen.dart';
import 'package:knm_masjid_app/screens/detailmasjid.dart';
import 'package:knm_masjid_app/screens/favorites.dart';
import 'package:knm_masjid_app/screens/login.dart';
import 'package:knm_masjid_app/screens/notify.dart';
// screens
import 'package:knm_masjid_app/screens/onboarding.dart';
import 'package:knm_masjid_app/screens/home.dart';
import 'package:knm_masjid_app/screens/profile.dart';
import 'package:knm_masjid_app/screens/notifications.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:knm_masjid_app/screens/splash.dart';
import 'controller/send_push_notication.controller.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  ///below code is commented as we don't want to save the message each time the user receives the message instead we are saving one time at the time of sending.
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // // Parse the message received
  // PushNotification notification = PushNotification(
  //     title: message.notification?.title,
  //     body: message.notification?.body,
  //     userRole: message.data.isNotEmpty && message.data.containsKey('userRole') ? message.data['userRole'] : UserRole.COMMITTEE.name
  // );
  //
  // // Save the notification data to Firestore
  // await FirebaseFirestore.instance.collection('notifications').doc().set({
  //   'title': message.notification?.title,
  //   'body': message.notification?.body,
  //   'userRole': message.data.isNotEmpty && message.data.containsKey('userRole') ? message.data['userRole'] : UserRole.COMMITTEE.name
  // });
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await GetStorage.init();
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>  with WidgetsBindingObserver{
  late final FirebaseMessaging _messaging;

  void requestAndRegisterNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _messaging.setForegroundNotificationPresentationOptions(badge: true, alert: true, sound: true);
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _messaging.getToken();
      print("token $token");
      Get.find<AuthController>().setFCM(token ?? "");
    }

  }

  Future<void> overlayPushNotification() async {

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge:true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{

      PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          userRole: message.data.isNotEmpty && message.data.containsKey('userRole')? message.data['userRole'] : UserRoleLocal.COMMITTEE.name
      );

      Get.snackbar(notification.title ?? "", notification.body ?? "");

    });
  }

  @override
  void initState() {
    super.initState();
    requestAndRegisterNotification();
    overlayPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'KNM Masjid Management',
        initialRoute: "/splash",
        debugShowCheckedModeBanner: false,
        initialBinding: BindingsBuilder(() {
          Get.put(AuthController(), permanent: true);
          Get.put(AppController(), permanent: true);
          Get.put(FavoriteController(), permanent: true);
          Get.put(MasjidController(), permanent: true);
          Get.put(SendPushController(), permanent: true);
        }),
        getPages: [
          GetPage(name: '/onboarding', page: () => const Onboarding()),
          GetPage(name: '/profile', page: () => Profile(), middlewares: [AuthMiddleware()]),
          GetPage(name: '/login', page: () => const Login()),
          GetPage(name: '/home', page: () => const Home()),
          GetPage(name: '/detailmasjid', page: () => DetailMasjid()),
          GetPage(name: '/crash', page: () => CrashScreen()),
          GetPage(name: '/splash', page: () => SplashScreen()),
          GetPage(name: '/announcements', page: () => const Announcements()),
          GetPage(name: '/add_masjid', page: () => const AddMasjid(), middlewares: [AuthMiddleware()]),
          GetPage(name: '/favorites', page: () => const Favorites(), middlewares: [AuthMiddleware()]),
          GetPage(name: '/notify', page: () => const Notify(), middlewares: [AuthMiddleware()]),
          GetPage(name: '/notifications', page: () => Notifications(), middlewares: [AuthMiddleware()])
        ],

        );
  }
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Get.find<AuthController>().isLoggedIn.value == false) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}
