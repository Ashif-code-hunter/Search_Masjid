// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_is_empty, unused_import, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/controller/auth.controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:knm_masjid_app/constants/Theme.dart';

import 'package:knm_masjid_app/screens/notifications.dart';
import 'package:knm_masjid_app/screens/search.dart';
import 'package:knm_masjid_app/widgets/input.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final List<String> tags;
  final Function getCurrentPage;
  final bool isOnSearch;
  final TextEditingController searchController;
  final Function searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;

  Navbar(
      {this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
      this.tags = const [],
      this.transparent = false,
      this.rightOptions = true,
      required this.getCurrentPage,
      required this.searchController,
      this.isOnSearch = false,
      required this.searchOnChanged,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = MyColors.white,
      this.searchBar = false});

  final double _prefferedHeight = 180.0;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {
  late String activeTag;

  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    if (widget.tags != null && widget.tags.length != 0) {
      activeTag = widget.tags[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    final displaySize = MediaQuery.of(context).size;

    final authC = Get.find<AuthController>();

    return Container(
        height: widget.searchBar
            ? displaySize.height * 0.2
            : displaySize.height * 0.1,
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? MyColors.initial
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: Offset(0, 5))
            ]),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                              !widget.backButton
                                  ? Icons.menu
                                  : Icons.arrow_back_ios,
                              color: !widget.transparent
                                  ? (widget.bgColor == MyColors.white
                                      ? MyColors.initial
                                      : MyColors.white)
                                  : MyColors.white,
                              size: 24.0),
                          onPressed: () {
                            if (!widget.backButton) {
                              Scaffold.of(context).openDrawer();
                            } else {
                              Navigator.pop(context);
                            }
                          }),
                      Text(widget.title,
                          style: TextStyle(
                              color: !widget.transparent
                                  ? (widget.bgColor == MyColors.white
                                      ? MyColors.initial
                                      : MyColors.white)
                                  : MyColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0)),
                    ],
                  ),
                  if (widget.rightOptions)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        !authC.isLoggedIn.value ? GestureDetector(
                          onTap: () {
                            Get.toNamed('/login');
                          },
                          child: IconButton(
                              icon: Icon(Icons.house_outlined,
                                  color: !widget.transparent
                                      ? (widget.bgColor == MyColors.white
                                          ? MyColors.initial
                                          : MyColors.white)
                                      : MyColors.white,
                                  size: 22.0),
                              onPressed: null),
                        ) : GestureDetector(
                          onTap: () {
                            authC.logOut();
                            Get.offAllNamed('/login');
                          },
                          child: IconButton(
                              icon: Icon(Icons.logout_outlined,
                                  color: !widget.transparent
                                      ? (widget.bgColor == MyColors.white
                                          ? MyColors.initial
                                          : MyColors.white)
                                      : MyColors.white,
                                  size: 22.0),
                              onPressed: null),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/notifications');
                          },
                          child: IconButton(
                              icon: Icon(Icons.notifications_active,
                                  color: !widget.transparent
                                      ? (widget.bgColor == MyColors.white
                                          ? MyColors.initial
                                          : MyColors.white)
                                      : MyColors.white,
                                  size: 22.0),
                              onPressed: null),
                        ),
                      ],
                    )
                ],
              ),
              if (widget.searchBar)
                Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Input(
                      placeholder: "Search For the Masjid .....",
                      controller: widget.searchController,
                      onChanged: widget.searchOnChanged,
                      autofocus: widget.searchAutofocus,
                      suffixIcon: Icon(Icons.zoom_in, color: MyColors.muted),
                      onTap: () {
                        if (!widget.isOnSearch) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search()));
                        }
                      },
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                    )),
              categories
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                          },
                          child: Row(
                            children: [
                              Icon(Icons.camera,
                                  color: MyColors.initial, size: 22.0),
                              SizedBox(width: 10),
                              Text(widget.categoryOne,
                                  style: TextStyle(
                                      color: MyColors.initial, fontSize: 16.0)),
                            ],
                          ),
                        ),
                        SizedBox(width: 30),
                        Container(
                          color: MyColors.initial,
                          height: 25,
                          width: 1,
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                          },
                          child: Row(
                            children: [
                              Icon(Icons.shopping_cart,
                                  color: MyColors.initial, size: 22.0),
                              SizedBox(width: 10),
                              Text(widget.categoryTwo,
                                  style: TextStyle(
                                      color: MyColors.initial, fontSize: 16.0)),
                            ],
                          ),
                        )
                      ],
                    )
                  : Container(
                      height: 1,
                      child: ScrollablePositionedList.builder(
                        itemScrollController: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.tags.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              if (activeTag != widget.tags[index]) {
                                setState(() => activeTag = widget.tags[index]);
                                _scrollController.scrollTo(
                                    index:
                                        index == widget.tags.length - 1 ? 1 : 0,
                                    duration: Duration(milliseconds: 420),
                                    curve: Curves.easeIn);
                                if (widget.getCurrentPage != null) {
                                  widget.getCurrentPage(activeTag);
                                }
                              }
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: index == 0 ? 46 : 8, right: 8),
                                padding: EdgeInsets.only(
                                    top: 4, bottom: 4, left: 20, right: 20),
                                // width: 90,
                                decoration: BoxDecoration(
                                    color: activeTag == widget.tags[index]
                                        ? MyColors.primary
                                        : MyColors.secondary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0))),
                                child: Center(
                                  child: Text(widget.tags[index],
                                      style: TextStyle(
                                          color: activeTag == widget.tags[index]
                                              ? MyColors.white
                                              : MyColors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0)),
                                )),
                          );
                        },
                      ),
                    )
            ],
          ),
        ));
  }
}
