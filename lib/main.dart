import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubits/add_cards_cubit/add_card_cubit.dart';
import 'package:notes_app/cubits/read_cards_cubit/read_cards_cubit.dart';
import 'package:notes_app/models/card_model.dart';
import 'package:notes_app/views/notes_view.dart';
import 'package:notes_app/views/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Bloc.observer = SimpleBlocObserver();
  // await Hive.deleteBoxFromDisk(notesBox);
  Hive.registerAdapter(CardModelAdapter());
  await Hive.openBox<CardModel>(cardBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddCardCubit()),
        BlocProvider(create: (context) => ReadCardsCubit())

        // Add other BlocProviders here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Lato'),
        home: const NotesView(),
      ),
    );
  }
}
