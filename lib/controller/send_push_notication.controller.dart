import 'package:get/get.dart';

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
   await api.searchFCMAPI().then((value){
     fcmList.clear();
      for (var documentSnapshot in value.docs) {
        if (documentSnapshot.exists ) {
          if(documentSnapshot['role'] == tag){
            String fcmToken = documentSnapshot['fcm'];
            fcmList.add(fcmToken);
          }
        }
      }
    });
  final result = await sendPushNotification(title: title,body: body,tag: tag);
   return result;
  }


}
