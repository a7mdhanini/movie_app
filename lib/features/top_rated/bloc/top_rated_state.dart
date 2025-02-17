part of 'top_rated_bloc.dart';

@immutable
sealed class TopRatedStateAbstract {}

///----Movies States
class MoviesInitialState extends TopRatedStateAbstract {}

class MoviesLoadingState extends TopRatedStateAbstract {}

class MoviesSuccessState extends TopRatedStateAbstract {}

class MoviesErrorState extends TopRatedStateAbstract {
  final String message;
  MoviesErrorState({required this.message});
}

class MoviesEmptyState extends TopRatedStateAbstract {}
