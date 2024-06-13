// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/widgets/drawer.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  final List<int> _selectedIndexes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notify Admins"),
      ),
      drawer: const MyDrawer.Drawer(currentPage: "Notify"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.89,
                    height: 125,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: InkWell(
                            enableFeedback: false,
                            onTap: () {
                              setState(() {
                                if (_selectedIndexes.contains(index)) {
                                  _selectedIndexes.remove(index);
                                } else {
                                  _selectedIndexes.add(index);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: _selectedIndexes.contains(index) ? MyColors.initial : null,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.blue,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50.0),
                                        image: DecorationImage(
                                          image: AssetImage("assets/img/muslim-men2.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Admin ${index + 1}",
                                    style: TextStyle(color: _selectedIndexes.contains(index) ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  )
                ],
              ),
              TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Subject',
                      alignLabelWithHint: true,
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.solid, color: Colors.grey)))),
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
                  labelText: 'Message...',
                  alignLabelWithHint: true,
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(style: ButtonStyle(
                fixedSize: WidgetStateProperty.all<Size>(Size(Get.width, 50)),
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )
              ),onPressed: () {
                print(_selectedIndexes);
              }, child: const Text("Send"))
            ],
          ),
        ),
      ),
    );
  }
}
