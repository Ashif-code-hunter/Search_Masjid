import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knm_masjid_app/enum/role.dart';
import 'package:knm_masjid_app/model/majid.dart';
import 'package:knm_masjid_app/model/user.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  String fcmToken = '';
  Rxn<UserModel?> user = Rxn<UserModel?>();
  final box = GetStorage();


  String getName() {
    return user.value?.name ?? user.value?.email ?? 'Guest User';
  }

  void setFCM(String fcm) {
    fcmToken = fcm;
  }

  Future<bool> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      user.value = null;
      isLoggedIn.value = false;
      Get.snackbar('Logout', "Logout Successful");
      Get.offAllNamed('/login');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final credential = EmailAuthProvider.credential(email: email, password: password);
    try {
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        throw Exception('User not found');
      }

      final role = userDoc.data()?['role'] ?? 'viewer';
      final userRole =
          UserRoleLocal.values.firstWhere((r) => r.toString().contains(role), orElse: () => UserRoleLocal.VIEWER);
      final userModel = UserModel(
        userID: userCredential.user!.uid,
        phoneNumber: userCredential.user!.phoneNumber,
        photoURL: userCredential.user!.photoURL,
        name: userCredential.user!.displayName,
        email: userCredential.user!.email,
        password: password,
        role: userRole,
      );

      if (FirebaseAuth.instance.currentUser != null) {
        user.value = userModel;
        isLoggedIn.value = true;
        box.write('user', userModel);
        Get.snackbar('Hi There', "Login Successful");
        return true;
      }

      if (userRole == UserRoleLocal.MASJID) {
        final masjidDoc = await FirebaseFirestore.instance
            .collection('masjids')
            .where('email', isEqualTo: userCredential.user!.email)
            .get();

        if (masjidDoc.docs.isNotEmpty) {
          userModel.masjid = Masjid.fromJson(masjidDoc.docs.first.data());
        } else {
          throw Exception('Masjid not found');
        }
      }

      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

  UserModel? getStoredUser() {
    return box.read('user');
  }
}
