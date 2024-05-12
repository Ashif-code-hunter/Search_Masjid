// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/controller/fav.controller.dart';

class CardSquare extends StatelessWidget {
  const CardSquare(
      {super.key,
      this.title = "Placeholder Title",
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      required this.id});

  final String cta;
  final String img;
  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final favC = Get.find<FavoriteController>();

    return SizedBox(
        height: size.height * 0.35,
        width: null,
        child: Card(
            elevation: 0.4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 5,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                topRight: Radius.circular(6.0)),
                            image: DecorationImage(
                              image: AssetImage(img),
                              fit: BoxFit.cover,
                            )))),
                Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: MyColors.header, fontSize: 13)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cta,
                                style: TextStyle(
                                    color: MyColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600),
                              ),
                              Obx(() => IconButton(
                                  onPressed: () => {favC.toggleFav(id)},
                                  icon: Icon(
                                    favC.isFavorite(id)
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: favC.isFavorite(id)
                                        ? Colors.redAccent
                                        : MyColors.initial,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            )));
  }
}
