import 'package:get/get.dart';

import '../api/push_notification_apis.dart';

class SendPushController extends GetxController {
  List<String> fcmList = [];
  RxString searchQuary = ''.obs;
  PushNotificationAPI api = PushNotificationAPI();


Future<bool> sendPushNotification({required String title, required String body,required  bodyJson, required String tag})async{
  await api.sendNotification(title: title, body: body, tokens:fcmList, tag: tag,bodyJson: bodyJson).then((value){
    if(value == true){
      return true;
    }
  });
  return false;
}

  Future<bool>  searchUsers({required String title, required String body,required String bodyJson, required String tag}) async {
   await api.searchFCMAPI().then((value){
     fcmList.clear();
     for (var documentSnapshot in value.docs) {
       if (documentSnapshot.exists) {
         Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;
         if (data != null && data['role'] == tag) {
           // Check if 'fcm' field exists and is not null
           if (data.containsKey('fcm') && data['fcm'] != null) {
             String fcmToken = data['fcm'] as String;
             fcmList.add(fcmToken);
           }
           // If 'fcm' doesn't exist or is null, it will be ignored
         }
       }
     }
    });
  final result = await sendPushNotification(title: title,body: body,tag: tag,bodyJson: bodyJson);

   Get.toNamed("/home");

   return result;
  }


}
