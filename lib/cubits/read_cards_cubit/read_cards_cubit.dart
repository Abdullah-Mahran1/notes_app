import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/card_model.dart';

part 'read_cards_state.dart';

class ReadCardsCubit extends Cubit<ReadCardsState> {
  ReadCardsCubit() : super(ReadCardsInitial());

  fetchAll() {
    emit(ReadCardsLoading());
    var cardBox = Hive.box<CardModel>(cardBoxName);
    debugPrint('Attempting to read ${cardBox.length} cards from Hive');
    try {
      List<CardModel> cards = cardBox.values.toList();
      emit(ReadCardsSucceeded(cards: cards));
      print('Successfully read ${cards.length} cards');
      return cards;
    } catch (e) {
      debugPrint('Error reading from Hive: $e');
      // Handle the error gracefully, maybe return an empty list
      return [];
    }
  }
}
