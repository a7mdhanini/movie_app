import 'package:flutter_movie_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/features/discover/bloc/discover_bloc.dart';
import 'package:flutter_movie_app/features/discover/presentation/screens/show_movie_screen.dart';
import 'package:flutter_movie_app/features/discover/presentation/widgets/movie_tv_item.dart';
import 'package:flutter_movie_app/features/discover/repository/discover_repository.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DiscoverBloc(context, repository: DiscoverRepository())

            ///----Load movies on init
            ..add(MoviesLoadingEvent()),
      child: const DiscoverView(),
    );
  }
}

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  DiscoverViewState createState() => DiscoverViewState();
}

class DiscoverViewState extends State<DiscoverView> {
  bool isMoviesSelected = true;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSelection(bool isMovies) {
    setState(() {
      isMoviesSelected = isMovies;
      context.read<DiscoverBloc>().add(
            isMovies ? MoviesLoadingEvent() : TvShowsLoadingEvent(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        body: SafeArea(
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
                      _buildToggleButton('Movies', isMoviesSelected,
                          () => _toggleSelection(true)),
                      const VerticalDivider(
                          width: 20, thickness: 2, color: Colors.white),
                      _buildToggleButton('TV Shows', !isMoviesSelected,
                          () => _toggleSelection(false)),
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
                      if (state is MoviesErrorState ||
                          state is TvShowsErrorState) {
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
                          itemCount: state.moviesList.length,
                          itemBuilder: (context, index) {
                            return MovieTvItem(
                              overview: state.moviesList[index].overview,
                              posterPath: state.moviesList[index].posterPath,
                              title: state.moviesList[index].title,
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
                          itemCount: state.tvShowsList.length,
                          itemBuilder: (context, index) {
                            return MovieTvItem(
                              overview: state.tvShowsList[index].overview,
                              posterPath: state.tvShowsList[index].posterPath,
                              title: state.tvShowsList[index].name,
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

class SearchTextField extends StatelessWidget {
  final String? hintText;
  final void Function(String)? onChanged;
  final TextEditingController searchController;

  const SearchTextField({
    required this.searchController,
    required this.hintText,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: AppColors.primary),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
