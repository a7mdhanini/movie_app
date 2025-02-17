import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/features/discover/bloc/discover_bloc.dart';
import 'package:flutter_movie_app/features/discover/presentation/screens/show_movie_screen.dart';
import 'package:flutter_movie_app/features/discover/presentation/widgets/movie_tv_item.dart';
import 'package:flutter_movie_app/features/discover/presentation/widgets/search_text_field.dart';

class DiscoverContent extends StatelessWidget {
  DiscoverContent({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DiscoverBloc bloc = context.read<DiscoverBloc>();
    DiscoverBloc blocListener = context.watch<DiscoverBloc>();
    //bloc.state is MoviesLoadingState ? const SizedBox():

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///----Search Text Field
            SearchTextField(
              hintText: 'Search...',
              onChanged: (newVal) {},
              searchController: _searchController,
            ),

            ///----Toggle Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleButton('Movies', blocListener.isMoviesSelected,
                      () => bloc.add(ToggleMoviesTvEvent(isMovies: true))),
                  const VerticalDivider(
                      width: 20, thickness: 2, color: Colors.white),
                  _buildToggleButton('TV Shows', !blocListener.isMoviesSelected,
                      () => bloc.add(ToggleMoviesTvEvent(isMovies: false))),
                ],
              ),
            ),

            ///----Movie TV Show List
            Expanded(
              child: BlocBuilder<DiscoverBloc, DiscoverStateAbstract>(
                builder: (context, state) {
                  ///----Loading
                  if (state is MoviesLoadingState ||
                      state is TvShowsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  ///----Error
                  if (state is MoviesErrorState || state is TvShowsErrorState) {
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
                        return MovieTvItem(
                          overview: bloc.moviesList[index].overview,
                          posterPath: bloc.moviesList[index].posterPath,
                          title: bloc.moviesList[index].title,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailsScreen(),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

                  ///----Tv Success
                  if (state is TvShowsSuccessState) {
                    return ListView.builder(
                      itemCount: bloc.tvList.length,
                      itemBuilder: (context, index) {
                        return MovieTvItem(
                          overview: bloc.tvList[index].overview,
                          posterPath: bloc.tvList[index].posterPath,
                          title: bloc.tvList[index].name,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailsScreen(),
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

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.yellow : Colors.white,
        ),
      ),
    );
  }
}
