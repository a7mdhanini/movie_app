import 'package:flutter_movie_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/features/discover/bloc/discover_bloc.dart';
import 'package:flutter_movie_app/features/discover/presentation/screens/descover_content.dart';
import 'package:flutter_movie_app/features/discover/repository/discover_repository.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DiscoverBloc(context, repository: DiscoverRepository())

            ///----Load movies on init
            ..add(MoviesLoadingEvent()),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const Scaffold(
          backgroundColor: AppColors.darkBlue,

          ///------------///
          ///----Body----///
          ///------------///
          body: DiscoverContent(),
        ),
      ),
    );
  }
}
