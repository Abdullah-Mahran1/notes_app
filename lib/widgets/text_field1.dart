import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl; // Import intl package with alias
import 'dart:ui' as ui; // Import dart:ui package with alias

class TextField1 extends StatefulWidget {
  final String hintText;
  final String initialText;
  final int maxLines;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;

  const TextField1({
    Key? key,
    this.hintText = '',
    this.maxLines = 1,
    this.initialText = '',
    this.onSaved,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TextField1> createState() => _TextField1State();
}

class _TextField1State extends State<TextField1> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Directionality(
            textDirection: intl.Bidi.startsWithRtl(_textController.text)
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            child: TextFormField(
              controller: _textController,
              onSaved: widget.onSaved,
              onChanged: (value) {
                setState(() {}); // Update the directionality when text changes
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'field is required';
                } else {
                  return null;
                }
              },
              cursorColor: Colors.blue,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 12), // Adjusts the vertical padding
                hintText: widget.hintText,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.blue)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
