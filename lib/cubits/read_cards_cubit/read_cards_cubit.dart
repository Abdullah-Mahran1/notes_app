import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/card_model.dart';

part 'read_cards_state.dart';

class ReadCardsCubit extends Cubit<ReadCardsState> {
  ReadCardsCubit() : super(ReadCardsInitial());

  fetchAll() {
    emit(ReadCardsLoading());
    try {
      var cardBox = Hive.box<CardModel>(notesBox);
      emit(ReadCardsSucceeded(notes: cardBox.values.toList()));
    } catch (e) {
      emit(ReadCardsFailed(errorMsg: 'exception was thrown: ${e.toString()}'));

      // TODO
    }
  }
}
