import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/card_model.dart';

part '../cubit/add_card_state.dart';

class AddCardCubit extends Cubit<AddCardState> {
  AddCardCubit() : super(AddCardInitial());

  addNote(CardModel card) {
    emit(AddCardLoading());
    Future.delayed(const Duration(milliseconds: 500));

    try {
      var cardBox = Hive.box<CardModel>(notesBox);
      cardBox.add(card);
      emit(AddCardSucceeded());
    } catch (e) {
      emit(AddCardFailed(errorMsg: 'exception was thrown: ${e.toString()}'));

      // TODO
    }
  }
}


// Steps of creating a bloc:
// 1. Write States, abstract class and a child class for each state
// 2. Create a Cubit with modification methods
// 3. Create BlocProvider & BlocBuilder
// 4. Call BlocBuilding 
/*

Steps of adding a cubit:
  1. define states
  2. provide cubits
  3. use cubits
*/