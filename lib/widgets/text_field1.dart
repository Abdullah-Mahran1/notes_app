import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class TextField1 extends StatelessWidget {
  Color? focusBorderColor;
  String? hintText;
  TextField1({super.key, this.focusBorderColor, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: 20.0, horizontal: 12), // Adjusts the vertical padding

            hintText: hintText ?? '',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    BorderSide(color: focusBorderColor ?? primaryColor)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
      ),
    );
  }
}
