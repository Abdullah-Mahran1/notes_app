import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/read_cards_cubit/read_cards_cubit.dart';
import 'package:notes_app/models/card_model.dart';
import 'package:notes_app/widgets/custom_app_bar.dart';
import 'package:notes_app/widgets/text_field1.dart';

import '../models/card_model.dart';
import '../widgets/custom_app_bar.dart';

class NoteEditView extends StatelessWidget {
  NoteEditView({super.key, required this.card});
  CardModel card;

  @override
  Widget build(BuildContext context) {
    String title = card.title, descr = card.descr;

    return Scaffold(
        appBar: CustomAppBar(
            title: 'Note Edit',
            iconButton: IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                card.title = title;
                card.descr = descr;
                card.save();
                BlocProvider.of<ReadCardsCubit>(context).fetchAll();
                Navigator.pop(context);
              },
            )),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextField1(
                  initialText: card.title,
                  onChanged: (val) {
                    title = val ?? '';
                  }),
              const SizedBox(height: 30),
              TextField1(
                  initialText: card.descr,
                  onChanged: (val) {
                    descr = val ?? '';
                  },
                  maxLines: 15),
            ],
          ),
        ));
  }
}
