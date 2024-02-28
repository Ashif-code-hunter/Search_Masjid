// ignore_for_file: deprecated_member_use, sized_box_for_whitespace, prefer_const_constructors, curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:knm_masjid_app/constants/Theme.dart';

import 'package:knm_masjid_app/widgets/drawer-tile.dart';

class MyDrawer extends StatelessWidget {
  final String currentPage;

  MyDrawer.Drawer({super.key, required this.currentPage});

  final List<Map<String, dynamic>> drawerItems = [
    {
      "title": "Home",
      "icon": Icons.home,
      "onTap": () {},
      "iconColor": Colors.amber
    },
    {
      "title": "About",
      "icon": Icons.info,
      "onTap": () {},
      "iconColor": MyColors.primary
    },
    {
      "title": "Broadcast Messages",
      "icon": Icons.message,
      "onTap": () {},
      "iconColor": MyColors.primary
    },
    {
      "title": "Announcements",
      "icon": Icons.speaker_notes,
      "onTap": () {},
      "iconColor": MyColors.primary
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: MyColors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
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
                        "KNM Masjid Management System",
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
        Expanded(
            flex: 2,
            child: ListView.builder(
                itemBuilder: (context, index) => DrawerTile(
                    icon: drawerItems[index]["icon"],
                    onTap: drawerItems[index]["onTap"],
                    iconColor: drawerItems[index]["iconColor"],
                    title: drawerItems[index]["title"],
                    isSelected: currentPage == drawerItems[index]["title"]
                        ? true
                        : false),
                itemCount: drawerItems.length)),
        Expanded(
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
                      onTap: () {},
                      iconColor: MyColors.muted,
                      title: "Profile",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                  DrawerTile(
                      icon: Icons.logout,
                      onTap: () {},
                      iconColor: MyColors.muted,
                      title: "Log Out",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }
}
