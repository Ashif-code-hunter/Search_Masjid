import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knm_masjid_app/api/masjid.api.dart';
import 'package:knm_masjid_app/enum/role.dart';
import 'package:knm_masjid_app/model/majid.dart';

import '../api/push_notification_apis.dart';

class SendPushController extends GetxController {
  List fcmList = [];
  RxString searchQuary = ''.obs;



  Future<void> searchUsers() async {
    PushNotificationAPI api = PushNotificationAPI();
   await api.searchFCMAPI("ADMIN").then((value){
     fcmList.clear();
      for (var documentSnapshot in value.docs) {
        if (documentSnapshot.exists ) {
          if(documentSnapshot['role'] == UserRole.MASJID.name){
            String fcmToken = documentSnapshot['fcm'];
            fcmList.add(fcmToken);
          }

        }
      }
    });
    print(fcmList);
  }


}
