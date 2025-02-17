import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/features/discover/models/movies_model.dart';
import 'package:flutter_movie_app/features/discover/models/tv_model.dart';
import 'package:flutter_movie_app/features/discover/repository/discover_repository.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEventAbstract, DiscoverStateAbstract> {
  final DiscoverRepository repository;
  final BuildContext context;

  List<MoviesModel> moviesList = [];
  List<TvModel> tvList = [];

  bool isMoviesSelected = true;

  DiscoverBloc(this.context, {required this.repository})
      : super(MoviesInitialState()) {
    on<MoviesLoadingEvent>(_onLoadMovies);
    on<TvShowsLoadingEvent>(_onLoadTvShows);
    on<ToggleMoviesTvEvent>(_onToggleMoviesTv);
  }

  ///-------------------///
  ///----Load Movies----///
  ///-------------------///
  Future<void> _onLoadMovies(
      MoviesLoadingEvent event, Emitter<DiscoverStateAbstract> emit) async {
    emit(MoviesLoadingState());
    final result = await repository.getMovies();

    result.fold(
      (failure) {
        log('Movies Failure: ${failure.message}');
        emit(MoviesErrorState(message: failure.message));
      },
      (success) {
        log('Movies Success');
        if (success.isEmpty) {
          emit(MoviesEmptyState());
        } else {
          moviesList = success;
          emit(MoviesSuccessState());
        }
      },
    );
  }

  ///---------------------///
  ///----Load TV Shows----///
  ///---------------------///
  Future<void> _onLoadTvShows(
      TvShowsLoadingEvent event, Emitter<DiscoverStateAbstract> emit) async {
    emit(TvShowsLoadingState());
    final result = await repository.getTvShows();

    result.fold(
      (failure) {
        log('TV Shows Failure: ${failure.message}');
        emit(TvShowsErrorState(message: failure.message));
      },
      (success) {
        log('TV Shows Success');
        if (success.isEmpty) {
          emit(TvShowsEmptyState());
        } else {
          tvList = success;
          emit(TvShowsSuccessState());
        }
      },
    );
  }

  ///------------------------///
  ///----Toggle Movies/TV----///
  ///------------------------///
  void _onToggleMoviesTv(
      ToggleMoviesTvEvent event, Emitter<DiscoverStateAbstract> emit) {
    isMoviesSelected = event.isMovies;
    emit(ToggleMoviesTvState());

    if (isMoviesSelected) {
      add(MoviesLoadingEvent());
    } else {
      add(TvShowsLoadingEvent());
    }
  }
}
