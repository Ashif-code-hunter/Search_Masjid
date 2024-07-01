import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/api/masjid.api.dart';
import 'package:knm_masjid_app/model/majid.dart';

class MasjidController extends GetxController {
  RxList<Masjid> masjidList = <Masjid>[].obs;
  RxString searchQuary = ''.obs;

  void setMasjid(List<DocumentSnapshot<Object?>> masjids) {
    List<Masjid> mData = [];
    for (var masjidData in masjids) {
      List<dynamic>? membersData = masjidData['members'] as List<dynamic>?;

      List<Member> members = membersData
              ?.map((e) {
                if (e is Map<String, dynamic>) {
                  return Member(
                    image: e['image'] ?? '',
                    phone: e['phone'],
                    name: e['name'],
                    position: e['position'],
                    type: e['type'],
                  );
                } else {
                  if (kDebugMode) {
                    print(
                        'Warning: An element in membersData is not a Map<String, dynamic>');
                  }
                  return null;
                }
              })
              .where((element) => element != null)
              .cast<Member>()
              .toList() ??
          [];

      Masjid masjid = Masjid(
        id: masjidData['id'],
        name: masjidData['name'],
        address: masjidData['address'],
        image: masjidData['image'],
        type: masjidData['type'],
        members: members,
        fcmToken: masjidData['fcmToken'],
      );

      mData.add(masjid);
    }

    masjidList.value = mData;
  }

  void searchMasjids() {
    MasjidAPI api = MasjidAPI();
    api.searchMasjidsAPI(searchQuary.value).then((value) {
      try {
        setMasjid(value);
      } catch (e) {
        if (kDebugMode) {
          print('No Element Found $e');
        }
      }
    });
    print(masjidList);
  }

  @override
  void onInit() {
    debounce(searchQuary, (_) => {searchMasjids()},
        time: const Duration(seconds: 2));
    super.onInit();
  }
}
