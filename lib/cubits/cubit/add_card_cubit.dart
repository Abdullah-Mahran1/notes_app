import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/models/card_model.dart';

part 'add_card_state.dart';

class AddCardCubit extends Cubit<AddCardState> {
  AddCardCubit() : super(AddCardInitial());

  addNote(CardModel card) {}
}

/*

Steps of adding a cubit:
  1. define states
  2. provide cubits
  3. use cubits
*/