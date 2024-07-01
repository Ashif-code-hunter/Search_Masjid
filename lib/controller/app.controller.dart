import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/controller/auth.controller.dart';
import 'package:knm_masjid_app/enum/role.dart';

class AppController extends GetxController {
  RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getNotifications() async {
    isLoading(true);
    try {
      final authC = Get.find<AuthController>();
      String role = authC.user.value!.role!.toRoleString();
      print(role);
      QuerySnapshot notificationsSnapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .where('userRole', isEqualTo: role)
          .get();
      notifications.value = notificationsSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}

extension on UserRoleLocal {
  String toRoleString() {
    switch (this) {
      case UserRoleLocal.ADMIN:
        return 'ADMIN';
      case UserRoleLocal.COMMITTEE:
        return 'COMMITTEE';
      default:
        return 'MASJID';
    }
  }
}
