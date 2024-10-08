import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/api/masjid.api.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/controller/masjid.controller.dart';
import 'package:knm_masjid_app/enum/role.dart';
import 'package:knm_masjid_app/model/majid.dart';
//widgets
import 'package:knm_masjid_app/widgets/navbar.dart';
import 'package:knm_masjid_app/widgets/card-horizontal.dart';
import 'package:knm_masjid_app/widgets/card-square.dart';
import 'package:knm_masjid_app/widgets/drawer.dart';

import '../controller/send_push_notication.controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Home",
        searchBar: true,
        getCurrentPage: () {},
        searchController: TextEditingController(),
        searchOnChanged: (String value) {
          Get.find<MasjidController>().searchQuery(value);
        },
      ),
      backgroundColor: MyColors.bgColorScreen,
      drawer: const MyDrawer.Drawer(currentPage: "Home"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (MasjidController.to.masjidList.isEmpty) {
                  return const Center(child: Text("Searched Masjid is not available"));
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      Masjid masjidData = MasjidController.to.masjidList[index];
                      String type = masjidData.type.toString();
                      return type == "registered"
                          ? Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                        child: _buildCardSquare(
                            context,
                            masjidData.name,
                            masjidData.address,
                            masjidData.image,
                            masjidData),
                      )
                          : Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: _buildCardHorizontal(
                            context: context,
                            name: masjidData.name,
                            address: masjidData.address,
                            img: masjidData.image,
                            data: masjidData),
                      );
                    },
                    itemCount: MasjidController.to.masjidList.length,
                  );
                }
              }),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // Get.find<SendPushController>().searchUsers(tag: UserRoleLocal.MASJID.name,body: "FCM",title: "FCM List body");
      //   },
      //   child: const Icon(Icons.send),
      // ),
    );
  }
  Widget _buildCardHorizontal(
      {required BuildContext context,
        required  String name,
        required String address,
        required  String img,
        required Masjid data}) {
    return GestureDetector(
      child: CardHorizontal(
        cta: "View more",
        title: name,
        img: img,
        id: data.id,
        address: address,
      ),
      onTap: () {
        Get.toNamed('/detailmasjid', arguments: data);
      },
    );
  }

  Widget _buildCardSquare(BuildContext context, String tag, String title,
      String img, Masjid data) {

    return GestureDetector(
      child: CardSquare(
        cta: "View more",
        title: title,
        img: img,
        id: data.id,
      ),
      onTap: () {
        Get.toNamed('/detailmasjid', arguments: data);
      },
    );
  }
// Rest of the code remains the same...
}


