import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:knm_masjid_app/api/firebase.api.dart';
import 'package:knm_masjid_app/data/temp.dart';

class PushNotificationAPI {


  Future<QuerySnapshot<Object?>> searchFCMAPI(
      String searchQuery) async {
    print("sssssssssssss");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .get();
    print("222sss ${querySnapshot}");

    return querySnapshot;
  }



}
