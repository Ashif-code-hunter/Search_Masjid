import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:knm_masjid_app/api/firebase.api.dart';
import 'package:knm_masjid_app/data/temp.dart';

class MasjidAPI {
  Future<List<DocumentSnapshot<Object?>>> getAllMasjidAPI(
      String collection, String? docId) {
    CollectionReference masjids =
        FirebaseFirestore.instance.collection(collection);
    Future<List<QueryDocumentSnapshot<Object?>>> masjidList =
        masjids.get().then((value) => value.docs);
    
    return masjidList;
  }

  Future<List<DocumentSnapshot<Object?>>> searchMasjidsAPI(
      String searchQuery) async {
    CollectionReference masjids =
        FirebaseFirestore.instance.collection("masjids");
    QuerySnapshot<Object?> querySnapshot = await masjids
        .where('name', isGreaterThanOrEqualTo: searchQuery)
        .where('name', isLessThan: '${searchQuery}z')
        .get();
    List<DocumentSnapshot<Object?>> masjidList = querySnapshot.docs;
    print(masjidList);
    return masjidList;
  }

  String setDummydata() {
    setDataToFirebase(knm_masjid_temp_data);
    return "Dummy Data Set";
  }

}
