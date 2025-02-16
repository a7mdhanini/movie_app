part of 'cards_bloc.dart';

@immutable
sealed class CardsEventAbstract {}

class CardsLoadingEvent extends CardsEventAbstract {}

class AddNewCardEvent extends CardsEventAbstract {
  final CardModel card;
  AddNewCardEvent(this.card);
}

class UpdateCardIndexEvent extends CardsEventAbstract {
  final int index;
  UpdateCardIndexEvent(this.index);
}
