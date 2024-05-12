import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/api/masjid.api.dart';
import 'package:knm_masjid_app/model/majid.dart';

class MasjidController extends GetxController {
  RxList masjidList = <Masjid>[].obs;
  RxString searchQuary = ''.obs;

  void setMasjid(List<DocumentSnapshot<Object?>> masjids) {
    List<Masjid> mData = [];
    for (var masjidData in masjids) {
      Masjid masjid = Masjid(
        id: masjidData['id'],
        name: masjidData['name'],
        address: masjidData['address'],
        image: masjidData['image'],
        type: masjidData['type'],
        members: (masjidData['members'] as List<dynamic>)
            .map((e) => Member.fromJson(e))
            .toList(),
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
  }

  @override
  void onInit() {
    debounce(searchQuary, (_) => {searchMasjids()},
        time: const Duration(seconds: 2));
    super.onInit();
  }
}
