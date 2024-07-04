part of 'add_card_cubit.dart';

@immutable
sealed class AddCardState {}

final class AddCardInitial extends AddCardState {}

final class AddCardLoading extends AddCardState {}

final class AddCardSucceeded extends AddCardState {}

final class AddCardFailed extends AddCardState {
  final String errorMsg;

  AddCardFailed({required this.errorMsg});
}
