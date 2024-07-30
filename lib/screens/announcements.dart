import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/widgets/drawer.dart';

import '../controller/send_push_notication.controller.dart';
import '../enum/role.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    QuillController _controller = QuillController.basic();
    TextEditingController titleController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Announcements")),
        drawer: const MyDrawer.Drawer(currentPage: "Announcements"),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
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
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey
                        ),
                      ),
                      child: Column(
                        children: [
                          QuillToolbar.simple(
                            configurations: QuillSimpleToolbarConfigurations(
                              controller: _controller,
                              showSuperscript: false,

                              sharedConfigurations: const QuillSharedConfigurations(
                                locale: Locale('de'),
                              ),
                            ),
                          ),
                          Divider(height: 1,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: QuillEditor.basic(
                                configurations: QuillEditorConfigurations(
                                  controller: _controller,
                                  checkBoxReadOnly: false,
                                  sharedConfigurations: const QuillSharedConfigurations(
                                    locale: Locale('de'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // TextFormField(
                    //   minLines: 10,
                    //   maxLength: null,
                    //   keyboardType: TextInputType.multiline,
                    //   maxLines: null,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     labelText: 'Announcements',
                    //     alignLabelWithHint: true,
                    //     labelStyle: const TextStyle(color: Colors.black),
                    //     focusedBorder: const OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),

                  ],
                ),
              ),
            ),
            isLoading
                ? Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      color: const Color(0x66ffffff),
                      child: CircularProgressIndicator()
                    )))
                : SizedBox()
          ],
        ),
        floatingActionButton:  FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: MyColors.primary,
          onPressed: () async{
            setState(() {
              isLoading =true;
            });
            print(jsonEncode(_controller.document.toDelta().toJson()));
           await Get.find<SendPushController>().searchUsers(tag: UserRoleLocal.MASJID.name, bodyJson:  jsonEncode(_controller.document.toDelta().toJson()),title: titleController.text,body: _controller.document.toPlainText());
            setState(() {
              isLoading =false;
            });
          },          label: const Text("Publish", style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.send, color: Colors.white),
        ));
  }
}
