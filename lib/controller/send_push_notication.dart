import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knm_masjid_app/api/masjid.api.dart';
import 'package:knm_masjid_app/enum/role.dart';
import 'package:knm_masjid_app/model/majid.dart';

import '../api/push_notification_apis.dart';

class SendPushController extends GetxController {
  List<String> fcmList = [];
  RxString searchQuary = ''.obs;
  PushNotificationAPI api = PushNotificationAPI();


Future<bool> sendPushNotification({required String title, required String body, required String tag})async{
  await api.sendNotification(title: title, body: body, tokens:fcmList, tag: tag).then((value){
    if(value == true){
      return true;
    }
  });
  return false;
}

  Future<bool> searchUsers({required String title, required String body, required String tag}) async {
   await api.searchFCMAPI("ADMIN").then((value){
     fcmList.clear();
      for (var documentSnapshot in value.docs) {
        if (documentSnapshot.exists ) {
          if(documentSnapshot['role'] == UserRoleLocal.MASJID.name){
            String fcmToken = documentSnapshot['fcm'];
            fcmList.add(fcmToken);
          }
        }
      }
    });
  final result = await sendPushNotification(title: "FCM NOTIFICATION",body: "FCM NOTIFICATION BODY",tag: "ADMIN");
   return result;
    print(fcmList);
  }


}
