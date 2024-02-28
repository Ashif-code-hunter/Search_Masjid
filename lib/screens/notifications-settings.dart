// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:knm_masjid_app/constants/Theme.dart';

//widgets
import 'package:knm_masjid_app/widgets/navbar.dart';

class NotificationsSettings extends StatefulWidget {
  @override
  _NotificationsSettingsState createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends State<NotificationsSettings> {
  late bool switchValueOne;
  late bool switchValueTwo;
  late bool switchValueThree;
  late bool switchValueFour;

  @override
  void initState() {
    setState(() {
      switchValueOne = false;
      switchValueTwo = false;
      switchValueThree = false;
      switchValueFour = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Notifications Settings",
        backButton: true,
        rightOptions: false,
        getCurrentPage: () {},
        searchController: TextEditingController(),
        searchOnChanged: () {},
      ),
      backgroundColor: MyColors.bgColorScreen,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 36.0, right: 36.0),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text("Recommended Settings",
                      style: TextStyle(
                          color: MyColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("These are the most important settings",
                      style: TextStyle(color: MyColors.text, fontSize: 14)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Someone mentions me",
                        style: TextStyle(color: MyColors.text)),
                    Switch.adaptive(
                      value: switchValueOne,
                      onChanged: (bool newValue) =>
                          setState(() => switchValueOne = newValue),
                      activeColor: MyColors.primary,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Anyone follows me",
                        style: TextStyle(color: MyColors.text)),
                    Switch.adaptive(
                      value: switchValueTwo,
                      onChanged: (bool newValue) =>
                          setState(() => switchValueTwo = newValue),
                      activeColor: MyColors.primary,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Someone comments me",
                        style: TextStyle(color: MyColors.text)),
                    Switch.adaptive(
                      value: switchValueThree,
                      onChanged: (bool newValue) =>
                          setState(() => switchValueThree = newValue),
                      activeColor: MyColors.primary,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("A seller follows me",
                        style: TextStyle(color: MyColors.text)),
                    Switch.adaptive(
                      value: switchValueFour,
                      onChanged: (bool newValue) =>
                          setState(() => switchValueFour = newValue),
                      activeColor: MyColors.primary,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
