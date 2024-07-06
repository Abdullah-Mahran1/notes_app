import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class TextField1 extends StatelessWidget {
  final String hintText;
  final String initialText;
  final int maxLines;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  const TextField1(
      {super.key,
      this.hintText = '',
      this.maxLines = 1,
      this.initialText = '',
      this.onSaved,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
      child: TextFormField(
        onSaved: onSaved,
        onChanged: onChanged,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'field is required';
          } else {
            return null;
          }
        },
        cursorColor: primaryColor,
        maxLines: maxLines,
        initialValue: initialText,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 20.0, horizontal: 12), // Adjusts the vertical padding
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: primaryColor)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
      ),
    );
  }
}
