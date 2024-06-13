// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:knm_masjid_app/constants/Theme.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;

  const Input(
      {super.key, required this.placeholder,
      this.suffixIcon = const Icon(Icons.search, color: Colors.transparent),
      this.prefixIcon = const Icon(Icons.search, color: Colors.transparent),
      required this.onTap,
      required this.onChanged,
      this.autofocus = false,
      this.borderColor = MyColors.border,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: MyColors.muted,
        onTap: () => onTap,
        onChanged: (String value) => onChanged(value),
        controller: controller,
        autofocus: autofocus,
        style: TextStyle(height: 0.85, fontSize: 14.0, color: MyColors.initial),
        textAlignVertical: TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            filled: true,
            fillColor: MyColors.white,
            hintStyle: TextStyle(
              color: MyColors.muted,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
