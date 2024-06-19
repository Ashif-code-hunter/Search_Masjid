// ignore_for_file: unnecessary_new, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knm_masjid_app/controller/auth.controller.dart';
import 'package:knm_masjid_app/controller/fav.controller.dart';
import 'package:knm_masjid_app/controller/masjid.controller.dart';
import 'package:knm_masjid_app/firebase_options.dart';
import 'package:knm_masjid_app/screens/add_masjid.dart';
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

import 'controller/send_push_notication.dart';
import 'enum/role.dart';
import 'model/push_notification_model/push_notification_model.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Parse the message received
  PushNotification notification = PushNotification(
      title: message.notification?.title,
      body: message.notification?.body,
      userRole: message.data.isNotEmpty && message.data.containsKey('userRole') ? message.data['userRole'] : UserRole.COMMITTEE.name
  );

  // Save the notification data to Firestore
  await FirebaseFirestore.instance.collection('notifications').doc().set({
    'title': message.notification?.title,
    'body': message.notification?.body,
    'userRole': message.data.isNotEmpty && message.data.containsKey('userRole') ? message.data['userRole'] : UserRole.COMMITTEE.name
  });
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>  with WidgetsBindingObserver{
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  void requestAndRegisterNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();
    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _messaging.setForegroundNotificationPresentationOptions(badge: true, alert: true, sound: true);
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _messaging.getToken();
      Get.find<AuthController>().setFCM(token ?? "");
      print("token $token");
      // For handling the received notifications
    }
  }
  Future<void> overlayPushNotification() async {



    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge:true,
      sound: true,
    );



    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      // Parse the message received
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        userRole: message.data.isNotEmpty && message.data.containsKey('userRole')? message.data['userRole'] : UserRole.COMMITTEE.name
      );
      if(message.notification?.body !=null){
        setState(() {
          _notificationInfo = notification;
        });
        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          await FirebaseFirestore.instance.collection('notifications').doc().set({
            'title': message.notification?.title,
            'body': message.notification?.body,
            'userRole':  message.data.isNotEmpty && message.data.containsKey('userRole')? message.data['userRole'] : UserRole.COMMITTEE.name
          });
        }
      }
    });
  }
  @override
  void initState() {
    super.initState();
    requestAndRegisterNotification();
    overlayPushNotification();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }


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
          Get.put(SendPushController(), permanent: true);
        }),
        getPages: [
          GetPage(name: '/onboarding', page: () => const Onboarding()),
          GetPage(name: '/profile', page: () => Profile()),
          GetPage(name: '/login', page: () => const Login()),
          GetPage(name: '/home', page: () => const Home()),
          GetPage(name: '/detailmasjid', page: () => DetailMasjid()),
          GetPage(name: '/announcements', page: () => const Announcements()),
          GetPage(name: '/add_masjid', page: () => const AddMasjid()),
          GetPage(name: '/favorites', page: () => const Favorites(), binding: BindingsBuilder(() {
          })),
          GetPage(name: '/notify', page: () => const Notify()),
          GetPage(name: '/notifications', page: () => Notifications())
        ],

        );
  }
}
