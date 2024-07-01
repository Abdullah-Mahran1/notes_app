import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/entities/card_entity.dart';
import 'package:notes_app/widgets/card_widget.dart';
import 'package:notes_app/widgets/custom_app_bar.dart';
import 'package:notes_app/widgets/text_field1.dart';

class NotesView extends StatelessWidget {
  const NotesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ModalSheet();
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: const CustomAppBar(
        title: 'Notes',
        icon: Icons.search,
      ),
      body: Expanded(child: cardsListView()),
    );
  }
}

Widget cardsListView() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return CardWidget(
            cardEntity: CardEntity(
                color: Colors.cyan,
                title: 'Note #1',
                descr: 'This is the fst Note in the app',
                date: DateTime(2019, 1, 30)),
          );
        }),
  );
}

class ModalSheet extends StatelessWidget {
  ModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      SizedBox(
        height: 25,
      ),
      TextField1(hintText: 'Title'),
      SizedBox(height: 30),
      TextField1(hintText: 'Content', maxLines: 5),
      Expanded(
          child: Placeholder(
        color: Colors.transparent,
      )),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
        width: MediaQuery.of(context).size.width,
        height: 130,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            'Submit',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(primaryColor)),
        ),
      )
    ]));
  }
}
