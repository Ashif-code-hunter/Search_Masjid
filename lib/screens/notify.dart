import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/api/push_notification_apis.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/widgets/drawer.dart';
import 'package:knm_masjid_app/controller/masjid.controller.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  final MasjidController _masjidController = Get.put(MasjidController());
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final PushNotificationAPI _notificationAPI = PushNotificationAPI();
  final List<int> _selectedIndexes = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notify Masjids"),
      ),
      drawer: const MyDrawer.Drawer(currentPage: "Notify"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Obx(() {
                return Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.89,
                      height: 125,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          var masjid = _masjidController.masjidList[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                                  color: _selectedIndexes.contains(index)
                                      ? MyColors.initial
                                      : null,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.blue,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/muslim-men2.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      masjid.name,
                                      style: TextStyle(
                                          color:
                                              _selectedIndexes.contains(index)
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: _masjidController.masjidList.length,
                      ),
                    )
                  ],
                );
              }),
              TextFormField(
                controller: _subjectController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Subject',
                    alignLabelWithHint: true,
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid, color: Colors.grey))),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _messageController,
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
              isLoading ? const CircularProgressIndicator():  ElevatedButton(
                onPressed: () {
                  sendNotificationToMasjids();
                },
                child: const Text("Send"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendNotificationToMasjids() async {
    if (_selectedIndexes.isNotEmpty) {
      String subject = _subjectController.text;
      String message = _messageController.text;

      List<String> tokens = _selectedIndexes.map((index) {
        return _masjidController.masjidList[index].fcmToken!;
      }).toList();

      // print("ssss Token $tokens ${_masjidController.masjidList[0].}");
      setState(() {
        isLoading = true;
      });
      bool result = await _notificationAPI.sendNotification(
        title: subject,
        body: message,
        tokens: tokens,
        tag: 'MASJID', bodyJson: '',
      );
      setState(() {
        isLoading = false;
      });

      if (result) {
        Get.snackbar("Success", "Notifications sent successfully");
      } else {
        Get.snackbar("Error", "Failed to send notifications");
      }
    } else {
      Get.snackbar("Error", "Please select at least one Masjid");
    }
  }
}
