import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/dfareporting/v4.dart';
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

import '../controller/send_push_notication.dart';


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
          Get.find<MasjidController>().searchQuary(value);
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
              child: FutureBuilder(
                  future: MasjidAPI().getAllMasjidAPI('masjids', null),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<DocumentSnapshot<Object?>> data = snapshot.data!;
                      Get.find<MasjidController>().setMasjid(data);
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          Map<String, dynamic> masjid =
                              data[index].data() as Map<String, dynamic>;
                          Masjid masjidData = Masjid.fromJson(masjid);
                          String type = masjidData.type.toString();
                          return type == "registered"
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, top: 10),
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
                                      context,
                                      masjidData.name,
                                      masjidData.address,
                                      masjidData.image,
                                      masjidData
                                      ),
                                );
                        },
                        itemCount: data.length,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
       await FirebaseAnalytics.instance.logEvent(
          name: 'level_completed',
          parameters: {
            'level_number': 9,
          },
        );
        print("ddddddddd");
       Get.find<SendPushController>().searchUsers(tag: UserRoleLocal.MASJID.name,body: "FCM",title: "FCM List body");
        // await FirebaseAnalytics.instance.logEvent(
        //   name: "ADMIN",
        //   parameters: {
        //     "role": "ADMIN",
        //   },
        // );
      },
      child: Icon(Icons.abc),
      ),
    );
  }

  Widget _buildCardHorizontal(BuildContext context, String tag, String title,
      String img, Masjid data) {
    return GestureDetector(
      child: CardHorizontal(
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
}
