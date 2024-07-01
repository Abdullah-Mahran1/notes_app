import 'package:flutter/material.dart';
import 'package:notes_app/models/card_model.dart';
import 'package:notes_app/views/notes_view.dart';
import 'package:notes_app/widgets/card_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Lato'),
        home: const NotesView());
  }
}
