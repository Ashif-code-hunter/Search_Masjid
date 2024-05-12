
// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knm_masjid_app/model/majid.dart';

class FavoriteController extends GetxController {
  final fav = [].obs;
  final box = GetStorage();

  @override
  void onInit() {
    fav.value = box.read("favorites") ?? [];
    super.onInit();
  }

  @override
  void onClose() {
    box.write("favorites", fav.value);
    super.onClose();
  }

  bool isFavorite(String id) {
    return fav.contains(id);
  }

  void toggleFav(String id) {
    if (isFavorite(id)) {
      fav.remove(id);
    } else {
      fav.add(id);
    }
    box.write("favorites", fav.value);
  }

  Future<List<Masjid>> getFav() async {
    if (fav.value.isEmpty) return [];
    CollectionReference masjids =
        FirebaseFirestore.instance.collection("masjids");
    QuerySnapshot<Object?> querySnapshot =
        await masjids.where('id', whereIn: fav.value).get();
    List<DocumentSnapshot<Object?>> masjidList = querySnapshot.docs;
    List<Masjid> mData = [];
    for (var masjidData in masjidList) {
      Masjid masjid = Masjid(
        id: masjidData.id,
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
    return mData;
  }
}
