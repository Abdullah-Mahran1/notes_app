import 'dart:ui';

import 'package:hive_flutter/adapters.dart';

part 'card_model.g.dart';

@HiveType(typeId: 0)
class CardModel extends HiveObject {
  @HiveField(0)
  Color color;

  @HiveField(1)
  String title;

  @HiveField(2)
  String descr;

  @HiveField(3)
  DateTime date;
  CardModel(
      {required this.color,
      required this.title,
      required this.descr,
      required this.date});
}
