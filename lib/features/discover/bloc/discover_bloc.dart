import 'dart:async';
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
  final TextEditingController searchController = TextEditingController();

  List<MoviesModel> moviesList = [];
  List<TvModel> tvList = [];

  List<MoviesModel> filteredMoviesList = [];
  List<TvModel> filteredTvList = [];

  bool isMoviesSelected = true;

  DiscoverBloc(this.context, {required this.repository})
      : super(MoviesInitialState()) {
    on<MoviesLoadingEvent>(_onLoadMovies);
    on<TvShowsLoadingEvent>(_onLoadTvShows);
    on<ToggleMoviesTvEvent>(_onToggleMoviesTv);
    on<SearchMoviesTvEvent>(_onSearchMoviesTv);
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
          filteredMoviesList = success;
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
          filteredTvList = success;
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

  ///------------------------///
  ///----Search Movies Tv----///
  ///------------------------///
  FutureOr<void> _onSearchMoviesTv(
      SearchMoviesTvEvent event, Emitter<DiscoverStateAbstract> emit) {
    if (isMoviesSelected) {
      filteredMoviesList = moviesList
          .where((element) => element.title
              .toLowerCase()
              .contains(event.searchQuery.toLowerCase()))
          .toList();
      emit(SearchMoviesState());
    } else {
      filteredTvList = tvList
          .where((element) => element.name
              .toLowerCase()
              .contains(event.searchQuery.toLowerCase()))
          .toList();
      emit(SearchTvState());
    }

    log('filteredMoviesList: $filteredMoviesList');
    log('filteredTvList: $filteredTvList');
  }
}
