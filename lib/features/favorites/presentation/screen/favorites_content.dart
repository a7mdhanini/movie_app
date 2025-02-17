import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/features/favorites/bloc/favorite_bloc.dart';
import 'package:flutter_movie_app/features/favorites/presentation/widget/favorite_item.dart';

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
                  if (state is FavoritesLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  ///----Error
                  if (state is FavoritesErrorState) {
                    return Center(
                      child: Text(
                        'Error: ${state.toString()}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  ///----Movies Success
                  if (state is FavoritesSuccessState) {
                    return ListView.builder(
                      itemCount: bloc.favoritesList.length,
                      itemBuilder: (context, index) {
                        return TopRatedItem(
                          overview: bloc.favoritesList[index].overview,
                          posterPath: bloc.favoritesList[index].posterPath,
                          title: bloc.favoritesList[index].title,
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ShowMovieScreen(
                            //       isMovie: true,
                            //       model: bloc.favoritesList[index],
                            //     ),
                            //   ),
                            // );
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