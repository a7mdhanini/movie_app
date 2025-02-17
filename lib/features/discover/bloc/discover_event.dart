part of 'discover_bloc.dart';

@immutable
sealed class DiscoverEventAbstract {}

class MoviesLoadingEvent extends DiscoverEventAbstract {}

class TvShowsLoadingEvent extends DiscoverEventAbstract {}

class ToggleMoviesTvEvent extends DiscoverEventAbstract {
  final bool isMovies;
  ToggleMoviesTvEvent({required this.isMovies});
}

class SearchMoviesTvEvent extends DiscoverEventAbstract {
  final String searchQuery;
  SearchMoviesTvEvent({required this.searchQuery});
}
