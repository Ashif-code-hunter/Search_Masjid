import 'package:flutter/material.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/widgets/drawer.dart';

class Announcements extends StatelessWidget {
  const Announcements({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Announcements")),
        drawer: const MyDrawer.Drawer(currentPage: "Announcements"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Announcement Title',
                        alignLabelWithHint: true,
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.solid)))),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                      value: "General",
                      child: Text("General"),
                    ),
                    DropdownMenuItem(
                      value: "Masjid",
                      child: Text("Masjid"),
                    ),
                    DropdownMenuItem(
                      value: "Members",
                      child: Text("Members"),
                    ),
                  ],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Announcement Type',
                      alignLabelWithHint: true,
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.solid))),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                TextFormField(
                  minLines: 10,
                  maxLength: null,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Announcements',
                    alignLabelWithHint: true,
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: MyColors.primary,
          onPressed: () {},
          label: const Text("Publish", style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.send, color: Colors.white),
        ));
  }
}
