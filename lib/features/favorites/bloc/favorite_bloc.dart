import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/features/discover/models/movies_model.dart';
import 'package:flutter_movie_app/features/favorites/repository/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEventAbstract, FavoritesStateAbstract> {
  final FavoriteRepository repository;
  final BuildContext context;

  List<MoviesModel> favoritesList = [];

  FavoriteBloc(this.context, {required this.repository})
      : super(FavoritesInitialState()) {
    on<FavoriteLoadingEvent>(_onLoadFavorites);
  }

  ///----------------------///
  ///----Load Favorites----///
  ///----------------------///
  Future<void> _onLoadFavorites(
      FavoriteLoadingEvent event, Emitter<FavoritesStateAbstract> emit) async {
    emit(FavoritesLoadingState());
    final result = await repository.getFavorites();

    result.fold(
      (failure) {
        log('Favorites Failure: ${failure.message}');
        emit(FavoritesErrorState(message: failure.message));
      },
      (success) {
        if (success.isEmpty) {
          emit(FavoritesEmptyState());
        } else {
          favoritesList = success;
          emit(FavoritesSuccessState());
        }
      },
    );
  }
}