import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/features/cards/models/card_model.dart';
import 'package:flutter_movie_app/features/cards/repository/card_repository.dart';
part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEventAbstract, CardsStateAbstract> {
  final CardRepository repository;
  final BuildContext context;
  List<CardModel> cardsList = [];
  int currentIndex = 1;

  CardsBloc(this.context, {required this.repository})
      : super(CardsInitialState()) {
    on<CardsLoadingEvent>(_onLoadCards);
    on<AddNewCardEvent>(_onAddNewCard);
    on<UpdateCardIndexEvent>(_onUpdateCardIndex);
  }

  ///------------------///
  ///----Load Cards----///
  ///------------------///
  Future<void> _onLoadCards(
      CardsLoadingEvent event, Emitter<CardsStateAbstract> emit) async {
    emit(CardsLoadingState());
    final result = await repository.getCards();

    result.fold(
      (failure) {
        log('failure: ${failure.message}');
        emit(CardsErrorState(message: failure.message.toString()));
      },
      (success) {
        log('success: $success');
        if (success.isEmpty) {
          emit(CardsEmptyState());
        } else {
          cardsList = success;
          emit(CardsSuccessState());
        }
      },
    );
  }

  ///--------------------///
  ///----Add New Card----///
  ///--------------------///
  Future<void> _onAddNewCard(
      AddNewCardEvent event, Emitter<CardsStateAbstract> emit) async {
    emit(CardsLoadingState());

    final newCard = await repository.addCard(event.card);

    newCard.fold(
      (failure) {
        emit(CardsErrorState(message: failure.toString()));
      },
      (success) {
        emit(CardsSuccessState());
        cardsList.add(success);
      },
    );
  }

  ///-------------------------///
  ///----Update Card Index----///
  ///-------------------------///
  void _onUpdateCardIndex(
      UpdateCardIndexEvent event, Emitter<CardsStateAbstract> emit) {
    currentIndex = event.index;
    log('currentIndex: $currentIndex');
    emit(UpdateCardIndexState());
  }
}
