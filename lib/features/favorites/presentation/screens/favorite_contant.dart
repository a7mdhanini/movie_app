import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/features/discover/presentation/screens/show_movie_screen.dart';
import 'package:flutter_movie_app/features/favorites/bloc/favorite_bloc.dart';
import 'package:flutter_movie_app/features/top_rated/bloc/top_rated_bloc.dart';
import 'package:flutter_movie_app/features/top_rated/presentation/widgets/top_rated_item.dart';

class FavoriteContant extends StatelessWidget {
  const FavoriteContant({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteBloc bloc = context.read<FavoriteBloc>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///----Movie TV Show List
            Expanded(
              child: BlocBuilder<FavoriteBloc, FavoritesStateAbstract>(
                builder: (context, state) {
                  ///----Loading
                  if (state is MoviesLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  ///----Error
                  if (state is MoviesErrorState) {
                    return Center(
                      child: Text(
                        'Error: ${state.toString()}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  ///----Movies Success
                  if (state is MoviesSuccessState) {
                    return ListView.builder(
                      itemCount: bloc.favoritesList.length,
                      itemBuilder: (context, index) {
                        return TopRatedItem(
                          overview: bloc.favoritesList[index].overview,
                          posterPath: bloc.favoritesList[index].posterPath,
                          title: bloc.favoritesList[index].title,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowMovieScreen(
                                  isMovie: true,
                                  model: bloc.favoritesList[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

                  ///----Empty
                  return const Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
