// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/constants/Images.dart';

// widgets
import 'package:knm_masjid_app/widgets/navbar.dart';
import 'package:knm_masjid_app/widgets/table-cell.dart';

final Map<String, List<Map>> productCards = {
  "Shoes": [
    {
      "title": "Nike Air Max",
      "image": images["fashion"]?["Nike Air Max"],
    },
    {
      "title": 'Blue Adidas',
      "image": images["fashion"]?["Blue Adidas"],
    },
    {
      "title": 'Perfect Shoes',
      "image": images["fashion"]?["Perfect Shoes"],
    },
    {
      "title": 'Fashion Shoes',
      "image": images["fashion"]?["Fashion Shoes"],
    },
    {
      "title": 'Orange Sneakers',
      "image": images["fashion"]?["Orange Sneakers"],
    },
  ],
  "Beauty": [
    {
      "title": 'Makeup Kit',
      "image": images["fashion"]?["Makeup Kit"],
    },
    {
      "title": 'Lipstick Kit',
      "image": images["fashion"]?["Lipstick Kit"],
    },
    {
      "title": 'Premium Brushes',
      "image": images["fashion"]?["Premium Brushes"],
    },
    {
      "title": 'Fashion Colors',
      "image": images["fashion"]?["Fashion Colors"],
    },
    {
      "title": 'Pink Glitter',
      "image": images["fashion"]?["Pink Glitter"],
    },
  ],
  "Fashion": [
    {
      "title": 'Colorful Hearts',
      "image": images["fashion"]?["Colorful Hearts"],
    },
    {
      "title": 'Get purple inspiration',
      "image": images["fashion"]?["Get purple inspiration"],
    },
    {
      "title": 'Favorite high heels',
      "image": images["fashion"]?["Favorite high heels"],
    },
    {
      "title": 'Pastel Hearts Sunglasses',
      "image": images["fashion"]?["Pastel Hearts Sunglasses"],
    },
    {
      "title": 'Awesome destination',
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

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final myController = TextEditingController();

  String searchText = "";
  List results = [];

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  _searchText(String searchTerm) {
    setState(() {
      results.clear();
    });
    if (searchTerm.isNotEmpty) {
      productCards.forEach((k, v) => v.map((e) {
            if (e["title"].toLowerCase().contains(searchTerm.toLowerCase())) {
              setState(() {
                results.add(e);
              });
            }
          }).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          backButton: true,
          title: "Search",
          rightOptions: false,
          searchBar: true,

          getCurrentPage: () {},
          searchController: TextEditingController(),
          isOnSearch: true,
          searchOnChanged: (String typedText) {
            setState(() {
              searchText = typedText;
            });
            _searchText(searchText);
          },
          searchAutofocus: true,
        ),
        backgroundColor: MyColors.bgColorScreen,
        body: Container(
            padding: EdgeInsets.only(left: 27, right: 27, top: 24),
            child: searchText.isNotEmpty
                ? (results.isNotEmpty
                    ? ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Container())
                    : SingleChildScrollView(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "We didn't find \"$searchText\" in our store.",
                                  style: TextStyle(
                                      fontSize: 18, color: MyColors.text)),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                    "You can see more products from other categories.",
                                    style: TextStyle(
                                        fontSize: 18, color: MyColors.text)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: TableCellSettings(
                                    title: "Fashion",
                                    onTap: () {
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: TableCellSettings(
                                    title: "Beauty",
                                    onTap: () {
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 16.0),
                                child: Text("Daily Deals",
                                    style: TextStyle(
                                        fontSize: 18, color: MyColors.text)),
                              ),

                            ],
                          ),
                        ),
                      ))
                : Container()));
  }
}
