part of 'favorite_bloc.dart';

@immutable
sealed class FavoritesStateAbstract {}

///----Favorites States
class FavoritesInitialState extends FavoritesStateAbstract {}

class FavoritesLoadingState extends FavoritesStateAbstract {}

class FavoritesSuccessState extends FavoritesStateAbstract {}

class FavoritesErrorState extends FavoritesStateAbstract {
  final String message;
  FavoritesErrorState({required this.message});
}

class FavoritesEmptyState extends FavoritesStateAbstract {}
