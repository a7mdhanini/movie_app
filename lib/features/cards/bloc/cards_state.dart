part of 'cards_bloc.dart';

@immutable
sealed class CardsStateAbstract {}

class CardsInitialState extends CardsStateAbstract {}

class CardsLoadingState extends CardsStateAbstract {}

class CardsSuccessState extends CardsStateAbstract {}

class CardsErrorState extends CardsStateAbstract {
  final String message;
  CardsErrorState({required this.message});
}

class CardsEmptyState extends CardsStateAbstract {}

class UpdateCardIndexState extends CardsStateAbstract {}
