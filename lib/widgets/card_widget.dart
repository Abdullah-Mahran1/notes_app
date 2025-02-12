import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:notes_app/models/card_model.dart';
import 'package:notes_app/views/note_edit_view.dart';
import 'package:notes_app/widgets/delete_dialog_widget.dart';

class CardWidget extends StatelessWidget {
  final CardModel cardModel;
  const CardWidget({super.key, required this.cardModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('card tapped');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NoteEditView(card: cardModel);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(cardModel.color)),
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        height: 200,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(width: 230),
                          child: Directionality(
                            textDirection:
                                intl.Bidi.startsWithRtl(cardModel.title)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            child: Text(
                              cardModel.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(width: 230),
                          child: Directionality(
                            textDirection:
                                intl.Bidi.startsWithRtl(cardModel.descr)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            child: Text(
                              cardModel.descr,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            showDeleteConfirmationDialog(context, () {
                              cardModel.delete();
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      cardModel.date.toString(),
                      style: TextStyle(color: Colors.black.withOpacity(0.7)),
                    ),
                  ))
            ]),
      ),
    );
  }
}
