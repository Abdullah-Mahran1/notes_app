import 'package:flutter/material.dart';
import 'package:notes_app/entities/card_entity.dart';

class CardWidget extends StatelessWidget {
  CardEntity cardEntity;
  CardWidget({super.key, required this.cardEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: cardEntity.color),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      height: 250,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardEntity.title,
                      style: TextStyle(fontSize: 32, color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      cardEntity.descr,
                      style: TextStyle(
                          fontSize: 18, color: Colors.black.withOpacity(0.7)),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ))
          ],
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                cardEntity.date.toString(),
                style: TextStyle(color: Colors.black.withOpacity(0.7)),
              ),
            ))
      ]),
    );
  }
}
