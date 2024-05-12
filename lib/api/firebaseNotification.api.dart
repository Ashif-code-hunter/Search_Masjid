import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;


Future<bool> askPermission() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    return true;
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    return true;
  } else {
    return false;
  }
}


Future<String?> getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  return token;
}


Future<void> writeTokenToDatabase(String token) async {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  await FirebaseFirestore.instance.collection('users').doc(userId).set({
    'tokens': [token],
  }, SetOptions(merge: true));
}


Future<void> setupToken() async {
  final String? token = await getToken();
  await writeTokenToDatabase(token!);
  FirebaseMessaging.instance.onTokenRefresh.listen(writeTokenToDatabase);
}
