// ignore_for_file: use_key_in_widget_constructors, unnecessary_import, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:knm_masjid_app/constants/Theme.dart';

//widgets
import 'package:knm_masjid_app/widgets/navbar.dart';
import 'package:knm_masjid_app/widgets/drawer.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "Profile",
          transparent: true,
          getCurrentPage: () {},
          searchController: TextEditingController(),
          searchOnChanged: () {},
        ),
        backgroundColor: MyColors.bgColorScreen,
        drawer: MyDrawer.Drawer(currentPage: "Profile"),
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage("assets/img/profile-screen-bg.png"),
                      fit: BoxFit.fitWidth))),
          SafeArea(
            child: ListView(children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 74.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: .0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: MyColors.info,
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), 
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                "CONTACT",
                                                style: TextStyle(
                                                    color: MyColors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                            ),
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: MyColors.initial,
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                "EMAIL",
                                                style: TextStyle(
                                                    color: MyColors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Align(
                                          child: Text("My Masjid",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 28.0)),
                                        ),
                                        SizedBox(height: 10.0),
                                        Align(
                                          child: Text("Areekode, Malapuram",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w200)),
                                        ),
                                        Divider(
                                          height: 40.0,
                                          thickness: 1.5,
                                          indent: 32.0,
                                          endIndent: 32.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 32.0, right: 32.0),
                                          child: Align(
                                            child: Text(
                                                "A Masjid In Kerala, Malapuram, Areekode, Methalagadi",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        82, 95, 127, 1),
                                                    fontSize: 17.0,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                          ),
                                        ),
                                        SizedBox(height: 30.0),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25.0, left: 25.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "My Masjid",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                    color: MyColors.text),
                                              ),
                                              Text(
                                                "Show Full",
                                                style: TextStyle(
                                                    color: MyColors.primary,
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(20),
                                            height: 250,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 140,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/img/masjid1.jpg'),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Text("My Masjid Name", style: TextStyle(fontWeight: FontWeight.bold),),
                                                Text(
                                                  "Avocados are a versatile fruit known for their creamy texture and rich flavor. Packed with healthy fats and nutrients, they're not only delicious but also offer numerous health benefits. Avocado toas",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  )
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      // FractionalTranslation(
                      //     translation: Offset(0.0, -0.5),
                      //     child: Align(
                      //       child: CircleAvatar(
                      //         backgroundImage: AssetImage(
                      //             "assets/img/masjid.jpg"),
                      //         radius: 65.0,
                      //         // maxRadius: 200.0,
                      //       ),
                      //       alignment: FractionalOffset(0.5, 0.0),
                      //     ))
                    ]),
                  ],
                ),
              ),
            ]),
          )
        ]));
  }
}
