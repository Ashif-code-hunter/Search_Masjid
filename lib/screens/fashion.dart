// ignore_for_file: prefer_const_constructors, annotate_overrides, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/constants/Images.dart';

import 'package:knm_masjid_app/widgets/navbar.dart';
import 'package:knm_masjid_app/widgets/card-horizontal.dart';
import 'package:knm_masjid_app/widgets/card-small.dart';
import 'package:knm_masjid_app/widgets/card-square.dart';

import 'package:knm_masjid_app/screens/detailmasjid.dart';

final Map<String, List<Map>> fashionCards = {
  "Shoes": [
    {
      "title": "Nike Air Max - the best sport shoes",
      "image": images["fashion"]?["Nike Air Max"],
    },
    {
      "title": 'Blue Adidas - only for physically active',
      "image": images["fashion"]?["Blue Adidas"],
    },
  ],
  "Beauty": [
    {
      "title": 'Makeup Kit - for your inner beauty queen',
      "image": images["fashion"]?["Makeup Kit"],
    },
    {
      "title": 'Lipstick Kit - a date night you\'ll never miss',
      "image": images["fashion"]?["Lipstick Kit"],
    },
    {
      "title": 'Premium Brushes - blend it like a pro',
      "image": images["fashion"]?["Premium Brushes"],
    },
  ],
  "Fashion": [
    {
      "title": 'Colorful Hearts for the sunny beach',
      "image": images["fashion"]?["Colorful Hearts"],
    },
    {
      "title": 'Get purple inspiration from your inner diva',
      "image": images["fashion"]?["Get purple inspiration"],
    },
    {
      "title": 'Favorite high heels always on the go',
      "image": images["fashion"]?["Favorite high heels"],
    },
    {
      "title": 'Pastel Hearts Sunglasses - too fab for you',
      "image": images["fashion"]?["Pastel Hearts Sunglasses"],
    },
    {
      "title": 'Awesome destination you could only dream of',
      "image": images["fashion"]?["Awesome destination"],
    },
  ],
  "Places": [
    {
      "title": 'A literary journal published by the Black Earth.',
      "image": images["fashion"]
          ?["A literary journal published by the Black Earth."],
    },
    {
      "title": 'By submitting, you guarantee.',
      "image": images["fashion"]?["By submitting, you guarantee."],
    },
    {
      "title": 'All About Lights is located in Boie.',
      "image": images["fashion"]?["All About Lights is located in Boie."],
    },
    {
      "title": 'Meet our about play staff: click on any.',
      "image": images["fashion"]?["Meet our about play staff: click on any."],
    },
    {
      "title": 'Whether it comes from the Sun.',
      "image": images["fashion"]?["Whether it comes from the Sun."],
    },
  ],
};

final List<String> tags = ["Shoes", "Beauty", "Fashion", "Places"];

class Fashion extends StatefulWidget {
  @override
  _FashionState createState() => _FashionState();
}

class _FashionState extends State<Fashion> {
  String currentTag = '';

  _getCurrentPage(activeTag) {
    setState(() {
      currentTag = activeTag;
      print('currentTag is $currentTag');
    });
  }

  @override
  void initState() {
    currentTag = tags[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Fashion",
          tags: tags,
          getCurrentPage: _getCurrentPage,
          backButton: true,
          searchController: TextEditingController(),
          searchOnChanged: () {},
        ),
        backgroundColor: MyColors.bgColorScreen,
        body: Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CardHorizontal(
                      cta: "View article",
                      title: fashionCards[currentTag]?[0]['title'],
                      img: fashionCards[currentTag]?[0]['image'],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      CardSmall(
                          cta: "View article",
                          title: fashionCards[currentTag]?[1]['title'],
                          img: fashionCards[currentTag]?[1]['image'],
                          tap: () {}),
                      CardSmall(
                          cta: "View article",
                          title: fashionCards[currentTag]?[2]['title'],
                          img: fashionCards[currentTag]?[2]['image'],
                          tap: () {})
                    ],
                  ),
                  SizedBox(height: 8.0),
                  CardHorizontal(
                    cta: "View article",
                    title: fashionCards[currentTag]?[3]['title'],
                    img: fashionCards[currentTag]?[3]['image'],
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: CardSquare(
                      cta: "View article",
                      title: fashionCards[currentTag]?[4]['title'],
                      img: fashionCards[currentTag]?[4]['image'],
                    ),
                  )
                ],
              ),
            )));
  }
}
