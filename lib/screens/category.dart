// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:knm_masjid_app/constants/Theme.dart';

//widgets
import 'package:knm_masjid_app/widgets/navbar.dart';
import 'package:knm_masjid_app/widgets/slider-product.dart';
import 'package:knm_masjid_app/widgets/card-small.dart';

import 'package:knm_masjid_app/screens/detailmasjid.dart';

class Category extends StatelessWidget {
  final String screenTitle;
  final List imgArray;
  final List suggestionsArray;

  Category(
      {required this.screenTitle,
      required this.imgArray,
      required this.suggestionsArray});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: screenTitle,
        backButton: true,
        getCurrentPage: () {},
        searchController: TextEditingController(),
        searchOnChanged: () {},
      ),
      backgroundColor: MyColors.bgColorScreen,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                // height: 700,
                padding: EdgeInsets.only(top: 16.0),
                child: ProductCarousel(
                  imgArray: imgArray.cast<Map<String, String>>(),
                  key: key!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardSmall(
                      img: suggestionsArray[0]["img"] as String,
                      title: suggestionsArray[0]["title"] as String,
                      tap: () {},
                    ),
                    CardSmall(
                      img: suggestionsArray[1]["img"] as String,
                      title: suggestionsArray[1]["title"] as String,
                      tap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
