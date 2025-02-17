import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/features/discover/presentation/screens/show_movie_screen.dart';
import 'package:flutter_movie_app/features/top_rated/bloc/top_rated_bloc.dart';
import 'package:flutter_movie_app/features/top_rated/presentation/widgets/top_rated_item.dart';

class TopRatedContant extends StatelessWidget {
  const TopRatedContant({super.key});

  @override
  Widget build(BuildContext context) {
    TopRatedBloc bloc = context.read<TopRatedBloc>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///----Movie TV Show List
            Expanded(
              child: BlocBuilder<TopRatedBloc, TopRatedStateAbstract>(
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
                      itemCount: bloc.moviesList.length,
                      itemBuilder: (context, index) {
                        return TopRatedItem(
                          overview: bloc.moviesList[index].overview,
                          posterPath: bloc.moviesList[index].posterPath,
                          title: bloc.moviesList[index].title,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowMovieScreen(
                                  isMovie: true,
                                  model: bloc.moviesList[index],
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
