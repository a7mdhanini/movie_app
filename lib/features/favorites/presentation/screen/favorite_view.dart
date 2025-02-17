import 'package:flutter_movie_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/core/widgets/my_app_bar.dart';
import 'package:flutter_movie_app/features/favorites/bloc/favorite_bloc.dart';
import 'package:flutter_movie_app/features/favorites/presentation/screen/favorites_content.dart';
import 'package:flutter_movie_app/features/favorites/repository/favorite_repository.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoriteBloc(context, repository: FavoriteRepository())

            ///----Load movies on init
            ..add(FavoriteLoadingEvent()),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.darkBlue,

          ///--------------///
          ///----AppBar----///
          ///--------------///
          appBar:
              myAppBar(context, title: 'Favorites', isBack: false, actions: []),

          ///------------///
          ///----Body----///
          ///------------///
          body: const FavoriteContant(),
        ),
      ),
    );
  }
}