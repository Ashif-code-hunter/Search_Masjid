import 'package:flutter/material.dart';
import 'package:knm_masjid_app/constants/Theme.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final bool isSelected;
  final Color iconColor;

  DrawerTile(
      {required this.title,
      required this.icon,
      required this.onTap,
      this.isSelected = false,
      this.iconColor = MyColors.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        {onTap()}
      },
      child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: isSelected ? MyColors.primary : MyColors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Icon(icon,
                  size: 20, color: isSelected ? MyColors.white : iconColor),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(title,
                    style: TextStyle(
                        letterSpacing: .3,
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: isSelected
                            ? MyColors.white
                            : const Color.fromRGBO(0, 0, 0, 0.7))),
              )
            ],
          )),
    );
  }
}
