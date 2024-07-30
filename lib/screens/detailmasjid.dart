import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/model/majid.dart';

//widgets
import 'package:knm_masjid_app/widgets/navbar.dart';


class DetailMasjid extends StatelessWidget {
  final GFBottomSheetController _controller = GFBottomSheetController();

  DetailMasjid({super.key});

  final Masjid data = Get.arguments ?? [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "KNM Masjid Management",
        backButton: true,
        getCurrentPage: () {},
        searchController: TextEditingController(),
        searchOnChanged: () {
          
        },
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
                    child: Text(data.name,
                        style: const TextStyle(fontSize: 28.0, color: MyColors.text)),
                  ),
                  Text(data.address,
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                      style: const TextStyle(color: MyColors.text, fontSize: 14.0)),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          String type = data.members![index].type;
                          return GestureDetector(
                            onTap: () => {
                              type == "main" ? Get.dialog(
                                AlertDialog(
                                  icon: GFAvatar(
                                    shape: GFAvatarShape.standard,
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                        data.members?[index].image ?? ''),
                                  ),
                                  backgroundColor: Colors.white,
                                  content: SizedBox(
                                    height: 63,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.members![index].name,
                                          style: const TextStyle(
                                              color: MyColors.text,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data.members![index].position,
                                          style: const TextStyle(
                                              color: MyColors.text,
                                              fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    IconButton(
                                        onPressed: (() {
                                          Get.back();
                                        }),
                                        icon: const Icon(
                                          Icons.chat_bubble,
                                          color: MyColors.initial,
                                        )),
                                                                        IconButton(onPressed: (() {
                                      Get.back();
                                    }), icon: const Icon(Icons.call, color: MyColors.initial,)),
                                  ]
                                )
                              ) : Container()
                            },
                            child: GFListTile(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: type == 'main' ? 0 : 20),
                              avatar: type == 'sub'
                                  ? null
                                  : GFAvatar(
                                      backgroundImage: NetworkImage(
                                          data.members?[index].image ?? ''),
                                    ),
                              icon: type == 'sub'
                                  ? const Icon(
                                      Icons.call,
                                      color: MyColors.initial,
                                    )
                                  : Container(),
                              titleText: data.members![index].name,
                              subTitleText: data.members![index].position,
                            ),
                          );
                        },
                        itemCount: data.members?.length ?? 0),
                  )
                ],
              ),
            ],
          ),
        ),
      ]),
      bottomSheet: _buildBottomSheet(data, context),
      floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.initial,
          child: _controller.isBottomSheetOpened
              ? const Icon(Icons.keyboard_arrow_down, color: Colors.white)
              : const Icon(Icons.keyboard_arrow_up, color: Colors.white),
          onPressed: () {
            _controller.isBottomSheetOpened
                ? _controller.hideBottomSheet()
                : _controller.showBottomSheet();
          }),
    );
  }

  GFBottomSheet _buildBottomSheet(
      Masjid data, BuildContext context) {
    return GFBottomSheet(
      controller: _controller,
      animationDuration: 100,
      maxContentHeight: 150,
      stickyHeaderHeight: 100,
      stickyHeader: Container(
        decoration: const BoxDecoration(
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
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            Column(
              children: [
                Center(
                    child: Text(
                  data.address,
                  style: const TextStyle(
                      fontSize: 15, wordSpacing: 0.3, letterSpacing: 0.2),
                )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width / 2.5, 50),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {
                        },
                        child: const Row(
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
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {
                          // Respond to button press
                        },
                        child: const Row(
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
        child: const Row(
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
