// ignore_for_file: deprecated_member_use, sized_box_for_whitespace, prefer_const_constructors, curly_braces_in_flow_control_structures, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/controller/auth.controller.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/enum/role.dart';
import 'package:knm_masjid_app/widgets/drawer-tile.dart';

class MyDrawer extends StatelessWidget {

  final String currentPage;

  const MyDrawer.Drawer({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    print(authC.user.value);
    return Drawer(
        child: Container(
      color: MyColors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kerala Nadvathul Mujahideen",
                        style: TextStyle(
                            color: MyColors.text,
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                      ),
                      Text(
                        authC.getName(),
                        style: TextStyle(
                            color: MyColors.text,
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.width * 0.03),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        SizedBox(
          height: 20,
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              DrawerTile(
                title: "Home",
                icon: Icons.home,
                onTap: () => {
                  Get.back(),
                  Get.offAllNamed('/home')
                },
                isSelected: currentPage == "Home" ? true : false,
              ),
              authC.isLoggedIn.value && authC.user.value?.role == UserRole.ADMIN ? DrawerTile(
                title: "Announcements",
                icon: Icons.announcement_rounded,
                isSelected: currentPage == "Announcements" ? true : false,
                onTap: () => {
                  Get.back(),
                  Get.offAllNamed('/announcements')
                },
              ) : Container(),
              authC.isLoggedIn.value && authC.user.value?.role == UserRole.ADMIN ? DrawerTile(
                title: "Add Masjid",
                icon: Icons.announcement_rounded,
                isSelected: currentPage == "Add Masjid" ? true : false,
                onTap: () => {
                  Get.back(),
                  Get.offAllNamed('/add_masjid')
                },
              ) : Container(),
              authC.isLoggedIn.value ? DrawerTile(
                title: "Notify",
                icon: Icons.message,
                onTap: () => {
                  Get.back(),
                  Get.offAllNamed('/notify')
                },
                isSelected: currentPage == "Notify" ? true : false,
              ): Container(),
              DrawerTile(
                title: "Favorites",
                icon: Icons.favorite,
                onTap: () => {
                  Get.back(),
                  Get.offAllNamed('/favorites')
                },
                isSelected: currentPage == "Favorites" ? true : false,
              ),
            ],
          ),
        ),
        Spacer(),
        authC.isLoggedIn.value ? Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: MyColors.muted),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("Account Settings",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                      icon: Icons.person,
                      onTap: () {
                        Get.offAllNamed('/profile');
                      },
                      iconColor: MyColors.header,
                      title: "Profile",
                      isSelected:
                          currentPage == "Profile" ? true : false,
                  ),
                  DrawerTile(
                      icon: Icons.logout,
                      onTap: () {
                        Get.find<AuthController>().logOut();
                      },
                      iconColor: MyColors.error,
                      title: "Log Out",
                      isSelected:
                          currentPage == "Log Out" ? true : false
                          ),
                ],
              )),
        ) : Container()
      ]),
    ));
  }
}
