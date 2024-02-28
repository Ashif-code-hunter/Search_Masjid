// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unused_import, avoid_print, unnecessary_this

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:knm_masjid_app/constants/Theme.dart';

//widgets
import 'package:knm_masjid_app/widgets/navbar.dart';
import 'package:knm_masjid_app/widgets/slider.dart';

import 'package:knm_masjid_app/screens/chat.dart';
import 'package:knm_masjid_app/data/temp.dart';

class DetailMasjid extends StatelessWidget {
  final GFBottomSheetController _controller = GFBottomSheetController();

  Map<String, dynamic> data;

  DetailMasjid({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "KNM Masjid Management",
        backButton: true,
        getCurrentPage: () {},
        searchController: TextEditingController(),
        searchOnChanged: () {},
      ),
      extendBody: true,
      backgroundColor: MyColors.bgColorScreen,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                    child: Text(data["name"]!,
                        style: TextStyle(fontSize: 28.0, color: MyColors.text)),
                  ),
                  Text(data["address"]!,
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                      style: TextStyle(color: MyColors.text, fontSize: 14.0)),
                  SizedBox(height: 28),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          String type = data["members"]![index]["type"]!;
                          return GFListTile(
                            margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: type == 'main' ? 0 : 20),
                            avatar: type == 'sub'
                                ? null
                                : GFAvatar(
                                    backgroundImage: AssetImage(
                                        data["members"]![index]["image"]!),
                                  ),
                            icon: type == 'sub'
                                ? Icon(
                                    Icons.person,
                                    color: MyColors.initial,
                                  )
                                : Container(),
                            titleText: data["members"]![index]["name"]!,
                            subTitleText: data["members"]![index]["position"],
                          );
                        },
                        itemCount: data["members"]!.length),
                  )
                ],
              ),
            ],
          ),
        ),
      ]),
      bottomSheet: _buildBottomSheet(this.data, context),
      floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.initial,
          child: _controller.isBottomSheetOpened
              ? Icon(Icons.keyboard_arrow_down, color: Colors.white)
              : Icon(Icons.keyboard_arrow_up, color: Colors.white),
          onPressed: () {
            _controller.isBottomSheetOpened
                ? _controller.hideBottomSheet()
                : _controller.showBottomSheet();
          }),
    );
  }

  GFBottomSheet _buildBottomSheet(
      Map<String, dynamic> data, BuildContext context) {
    return GFBottomSheet(
      controller: _controller,
      animationDuration: 100,
      maxContentHeight: 150,
      stickyHeaderHeight: 100,
      stickyHeader: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 0)]),
        child: const GFListTile(
          icon: Icon(
            Icons.phone,
            color: MyColors.initial,
          ),
          titleText: 'Contact',
          subTitleText: 'Contact The Masjid',
        ),
      ),
      contentBody: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            Column(
              children: [
                Center(
                    child: Text(
                  data["address"]!,
                  style: TextStyle(
                      fontSize: 15, wordSpacing: 0.3, letterSpacing: 0.2),
                )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width / 2.5, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {
                          print("Call");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.message),
                            Text(' Whatsapp'),
                          ],
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width / 2.5, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {
                          // Respond to button press
                          print("Call");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.map),
                            Text(' Location'),
                          ],
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      stickyFooter: Container(
        color: MyColors.initial,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Get in touch',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "1234567890",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
      stickyFooterHeight: 50,
    );
  }
}
