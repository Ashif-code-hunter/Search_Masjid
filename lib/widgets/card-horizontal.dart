// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/controller/fav.controller.dart';

class CardHorizontal extends StatelessWidget {
  const CardHorizontal(
      {this.title = "Placeholder Title",
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      required this.id,
      });

  final String cta;
  final String img;
  final String title;
  final String id;

  static void defaultFunc() {
    print("the function works!");
  } 

  @override
  Widget build(BuildContext context) {

    final favC = Get.find<FavoriteController>();

    return Container(
        height: 150,
        child: Card(
          elevation: 0.6,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6.0),
                            bottomLeft: Radius.circular(6.0)),
                        image: DecorationImage(
                          image: AssetImage(img),
                          fit: BoxFit.cover,
                        ))),
              ),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: TextStyle(
                                color: MyColors.header, fontSize: 13)),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cta,
                              style: TextStyle(
                                  color: MyColors.primary,
                                  fontSize: 12,
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
                                    size: 20),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
