import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<void> setDataToFirebase(List<Map<String, dynamic>> masjidsData) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  for (var masjidData in masjidsData) {
    await firestore.collection('masjids').add({
      'name': masjidData['name'].toString().toLowerCase(),
      'address': masjidData['address'].toString().toLowerCase(),
      'image': masjidData['image'],
      'type': masjidData['type'].toString().toLowerCase(),
      'members': masjidData['members'],
    });
  }

  if (kDebugMode) {
    print('Data added to Firestore');
  }
}
