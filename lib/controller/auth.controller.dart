import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knm_masjid_app/enum/role.dart';
import 'package:knm_masjid_app/model/user.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  Rxn<UserModel?> user = Rxn<UserModel?>();
  final box = GetStorage();


  @override
  void onInit() {
    super.onInit();
  }


  String getName(){
    return user.value?.name ?? user.value?.email ?? 'Guest User';
  }

  bool valiedateTheLogin(String username, String password) {
    if (username.isEmpty) {
      Get.snackbar('Error', 'Please enter a username');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Error', 'Please enter a password');
      return false;
    }

    if (password.length < 8) {
      Get.snackbar('Error', 'Password must be at least 8 characters long');
      return false;
    }
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialChars = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUppercase || !hasDigits || !hasSpecialChars) {
      Get.snackbar('Error',
          'Password must contain at least one uppercase letter, one digit, and one special character');
      return false;
    }
    return true;
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
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final authuser = userCredential.user;
      if (authuser != null) {
        UserModel usermodel = UserModel(
          userID: authuser.uid,
          phoneNumber: authuser.phoneNumber,
          photoURL: authuser.photoURL,
          name: authuser.displayName,
          email: authuser.email,
          password: password,
          role: UserRole.MASJID, // ! #TODO
        );
        if (FirebaseAuth.instance.currentUser != null) {
          user.value = usermodel;
          isLoggedIn.value = true;
          box.write('user', user.value!.toJson());
          Get.snackbar('Hi There', "Login Successful");
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
