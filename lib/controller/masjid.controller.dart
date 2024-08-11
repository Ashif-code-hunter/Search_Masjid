import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/api/masjid.api.dart';
import 'package:knm_masjid_app/model/majid.dart';

class MasjidController extends GetxController {
  RxList<Masjid> masjidList = <Masjid>[].obs;
  RxList<Masjid> fullMasjidList = <Masjid>[].obs;
  RxString searchQuery = ''.obs;

  static MasjidController get to =>Get.find();


  void reset(){
    masjidList.value = fullMasjidList;
  }

  void setMasjid(List<DocumentSnapshot<Object?>> masjids) {
    List<Masjid> mData = [];

    if (masjids.isNotEmpty) {
      for (var masjidData in masjids) {
        List? membersData = masjidData['members'] as List?;

        List<Member> members = membersData
            ?.map((e) {
          if (e is Map) {
            return Member(
              image: e['image'] ?? '',
              phone: e['phone'],
              name: e['name'],
              position: e['position'],
              type: e['type'],
            );
          } else {
            if (kDebugMode) {
              print('Warning: An element in membersData is not a Map');
            }
            return null;
          }
        })
            .where((element) => element != null)
            .cast<Member>()
            .toList() ??
            [];

        // Check if name, image, or address is empty
        if (masjidData['name'] != null && masjidData['name'].isNotEmpty &&
            masjidData['image'] != null && masjidData['image'].isNotEmpty &&
            masjidData['address'] != null && masjidData['address'].isNotEmpty) {

          Masjid masjid = Masjid(
              id: masjidData['id'],
              name: masjidData['name'],
              address: masjidData['address'],
              image: masjidData['image'],
              type: masjidData['type'],
              members: members,
              fcmToken: masjidData['fcmToken'],
              masjidPhone: masjidData['masjidPhone']
          );

          mData.add(masjid);
        }
      }
    }

    masjidList.value = mData;
    if(searchQuery.value.isEmpty){
      fullMasjidList.value = mData;
    }
  }



  void searchMasjids() {
    if (searchQuery.value.isEmpty) {
      // If search query is empty, fetch all masjids
      MasjidAPI().getAllMasjidAPI('masjids', null).then((value) {
        setMasjid(value);
      });
    } else {
      MasjidAPI().searchMasjidsAPI(searchQuery.value.toLowerCase()).then((value) {
        try {
          setMasjid(value);
        } catch (e) {
          if (kDebugMode) {
            print('Error updating masjid list: $e');
          }
        }
      });
    }
  }

  @override
  void onInit() {
    // Initial load of all masjids
    MasjidAPI().getAllMasjidAPI('masjids', null).then((value) {
      setMasjid(value);
    });

    // Set up debounce for search
    debounce(searchQuery, (_) => searchMasjids(),
        time: const Duration(milliseconds: 500));
    super.onInit();
  }
}
