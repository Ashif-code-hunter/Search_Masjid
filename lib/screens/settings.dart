import 'package:flutter/material.dart';

import 'package:knm_masjid_app/constants/Theme.dart';

//widgets
import 'package:knm_masjid_app/widgets/navbar.dart';
import 'package:knm_masjid_app/widgets/table-cell.dart';

import 'package:knm_masjid_app/widgets/drawer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late bool switchValueOne;
  late bool switchValueTwo;

  @override
  void initState() {
    setState(() {
      switchValueOne = false;
      switchValueTwo = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Settings",
          getCurrentPage: () {},
          searchController: TextEditingController(),
          searchOnChanged: () {},
        ),
        drawer: const MyDrawer.Drawer(currentPage: "Settings"),
        body: SingleChildScrollView(
                  child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("Recommended Settings",
                    style: TextStyle(
                        color: MyColors.text,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("These are the most important settings",
                    style: TextStyle(color: MyColors.text, fontSize: 14)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Use FaceID to signin",
                    style: TextStyle(color: MyColors.text)),
                Switch.adaptive(
                  value: switchValueOne,
                  onChanged: (bool newValue) =>
                      setState(() => switchValueOne = newValue),
                  activeColor: MyColors.primary,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Auto-Lock security",
                    style: TextStyle(color: MyColors.text)),
                Switch.adaptive(
                  value: switchValueTwo,
                  onChanged: (bool newValue) =>
                      setState(() => switchValueTwo = newValue),
                  activeColor: MyColors.primary,
                )
              ],
            ),
            const SizedBox(height: 36.0),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text("Payment Settings",
                    style: TextStyle(
                        color: MyColors.text,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("These are also important settings",
                    style: TextStyle(color: MyColors.text)),
              ),
            ),
            TableCellSettings(
              title: "Manage Payment Options",
              onTap: () {},
            ),
            TableCellSettings(
              title: "Manage Gift Cards",
              onTap: () {},
            ),
            const SizedBox(
              height: 36.0,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text("Privacy Settings",
                    style: TextStyle(
                        color: MyColors.text,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("Third most important settings",
                    style: TextStyle(color: MyColors.text)),
              ),
            ),
            TableCellSettings(
                title: "User Agreement",
                onTap: () {
                }),
            TableCellSettings(
                title: "Privacy",
                onTap: () {
                }),
            TableCellSettings(
                title: "About",
                onTap: () {
                }),
          ],
        ),
                  ),
                ));
  }
}
