// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/data/temp.dart';
import 'package:knm_masjid_app/screens/about.dart';
import 'package:knm_masjid_app/screens/chat.dart';
import 'package:knm_masjid_app/screens/elements.dart';
import 'package:knm_masjid_app/screens/profile.dart';
import 'package:knm_masjid_app/screens/settings.dart';

//widgets
import 'package:knm_masjid_app/widgets/navbar.dart';
import 'package:knm_masjid_app/widgets/card-horizontal.dart';
import 'package:knm_masjid_app/widgets/card-small.dart';
import 'package:knm_masjid_app/widgets/card-square.dart';
import 'package:knm_masjid_app/widgets/drawer.dart';

import 'package:knm_masjid_app/screens/detailmasjid.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = knm_masjid_temp_data;
    return Scaffold(
      appBar: Navbar(
        title: "Home",
        searchBar: true,
        getCurrentPage: () {},
        searchController: TextEditingController(),
        searchOnChanged: () {},
      ),
      backgroundColor: MyColors.bgColorScreen,
      drawer: MyDrawer.Drawer(currentPage: "Home"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  String? type = data[index]['type'];
                  return type == "registered"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                          child: _buildCardSquare(
                              context,
                              data[0]['name'],
                              data[index]['name']!,
                              data[index]['image']!,
                              data[index]),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: _buildCardHorizontal(
                              context,
                              data[index]['name'],
                              data[index]['address'],
                              data[index]['image']!,
                              data[index]),
                        );
                },
                itemCount: data.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHorizontal(BuildContext context, String tag, String title,
      String img, Map<String, dynamic> data) {
    return GestureDetector(
      child: CardHorizontal(
        cta: "View more",
        title: title,
        img: img,
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailMasjid(data: data)));
      },
    );
  }

  Widget _buildCardSquare(BuildContext context, String tag, String title,
      String img, Map<String, dynamic> data) {
    return GestureDetector(
      child: CardSquare(
        cta: "View more",
        title: title,
        img: img,
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailMasjid(data: data)));
      },
    );
  }
}
