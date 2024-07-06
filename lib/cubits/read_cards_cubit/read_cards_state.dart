part of 'read_cards_cubit.dart';

@immutable
sealed class ReadCardsState {}

final class ReadCardsInitial extends ReadCardsState {}

final class ReadCardsLoading extends ReadCardsState {}

final class ReadCardsSucceeded extends ReadCardsState {
  final List<CardModel> cards;

  ReadCardsSucceeded({required this.cards});
}

final class ReadCardsFailed extends ReadCardsState {
  final String errorMsg;

  ReadCardsFailed({required this.errorMsg});
}
