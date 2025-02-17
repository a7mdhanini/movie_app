import 'package:flutter_movie_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/core/widgets/my_app_bar.dart';
import 'package:flutter_movie_app/features/top_rated/bloc/top_rated_bloc.dart';
import 'package:flutter_movie_app/features/top_rated/presentation/screens/top_rated_contant.dart';
import 'package:flutter_movie_app/features/top_rated/repository/top_rated_repository.dart';

class TopRatedView extends StatelessWidget {
  const TopRatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TopRatedBloc(context, repository: TopRatedRepository())

            ///----Load movies on init
            ..add(MoviesLoadingEvent()),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.darkBlue,

          ///--------------///
          ///----AppBar----///
          ///--------------///
          appBar: myAppBar(context,
              title: 'Top Rated Movies', isBack: false, actions: []),

          ///------------///
          ///----Body----///
          ///------------///
          body: const TopRatedContant(),
        ),
      ),
    );
  }
}
