
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/controller/app.controller.dart';
import 'package:knm_masjid_app/constants/Theme.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final appC = Get.find<AppController>();
  QuillController _controller = QuillController.basic();



  @override
  void initState() {
    super.initState();
    appC.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Obx(() {
        if (appC.notifications.isEmpty) {
          return const Center(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_off,
                        size: 48.0, color: MyColors.text),
                    SizedBox(height: 12),
                    Text(
                      'No notifications available',
                      style: TextStyle(
                          color: MyColors.text,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'You can check back later or enable notifications in settings.',
                      style: TextStyle(color: MyColors.muted),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: appC.notifications.length,
          itemBuilder: (BuildContext context, int index) {
            var notification = appC.notifications[index];


            return GestureDetector(
              onTap: () {
                Get.to(() => NotificationDetailsPage(notification: notification));
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification['title']?.length > 20
                                  ? '${notification['title']?.substring(0, 20)}...'
                                  : notification['title'] ?? 'No Title',
                              style: const TextStyle(
                                color: MyColors.text,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // QuillToolbar.simple(
                            //   configurations: QuillSimpleToolbarConfigurations(
                            //     controller: _controller,
                            //     showSuperscript: false,
                            //     showAlignmentButtons: false,
                            //     showBackgroundColorButton: false,
                            //     showBoldButton: false,
                            //     showCenterAlignment: false,
                            //     showClearFormat: false,,
                            //     sharedConfigurations: const QuillSharedConfigurations(
                            //       locale: Locale('de'),
                            //     ),
                            //   ),
                            // ),
                            Text(
                              notification['body'] ?? 'No additional information',
                              style: const TextStyle(color: MyColors.muted),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.timelapse, size: 16.0, color: MyColors.muted),
                      const SizedBox(width: 5),
                      Text(
                        notification['time'] ?? 'Just now',
                        style: const TextStyle(color: MyColors.muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class NotificationDetailsPage extends StatefulWidget {
  final Map<String, dynamic> notification;

  const NotificationDetailsPage({Key? key, required this.notification})
      : super(key: key);

  @override
  State<NotificationDetailsPage> createState() => _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    QuillController _controller = QuillController.basic();
    _controller.readOnly = true;

    String? body;

    if(!(widget.notification['bodyJson'] == null || widget.notification['bodyJson'] == "")){
      final json = jsonDecode(widget.notification['bodyJson']);
      _controller.document = Document.fromJson(json);
    }else{
      setState(() {
        body = widget.notification['body'];

      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.notification['title'] ?? 'No Title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          body == null ?  Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  autoFocus: false,
                  showCursor: false,
                  controller: _controller,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('de'),
                  ),
                ),
              ),
            ):

            Text(
             body ?? 'No additional information',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Received: ${widget.notification['time'] ?? 'Just now'}',
              style: const TextStyle(color: MyColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
