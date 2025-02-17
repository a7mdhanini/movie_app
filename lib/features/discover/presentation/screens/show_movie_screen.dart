import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/apis/api_base.dart';
import 'package:flutter_movie_app/core/themes/app_colors.dart';
import 'package:flutter_movie_app/core/utils/app_sizes.dart';
import 'package:flutter_movie_app/core/widgets/my_app_bar.dart';
import 'package:flutter_movie_app/core/widgets/my_image.dart';
import 'package:flutter_movie_app/core/widgets/my_image_zoom.dart';
import 'package:flutter_movie_app/core/widgets/texts/my_text.dart';
import 'package:flutter_movie_app/features/discover/models/movies_model.dart';
import 'package:flutter_movie_app/features/discover/models/tv_model.dart';
import 'package:flutter_movie_app/features/discover/presentation/widgets/add_to_cart_container.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShowMovieScreen extends StatelessWidget {
  final bool isMovie;
  final dynamic model;

  const ShowMovieScreen({
    super.key,
    required this.isMovie,
    required this.model,
  });
  @override
  Widget build(BuildContext context) {
    // final String title =
    //     isMovie ? (model as MoviesModel).title : (model as TvModel).name;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,

        ///--------------///
        ///----AppBar----///
        ///--------------///
        appBar: myAppBar(context, actions: [
          ///----Adult Icon
          MyText(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            text: isMovie
                ? (model as MoviesModel).adult
                    ? '18+'
                    : 'Family'
                : (model as TvModel).adult
                    ? '18+'
                    : 'Family',
            color: Colors.white,
            type: TextType.medium,
          ),
        ]),

        ///---------------------------------------///
        ///----Bottom Navigation Favorite Rate----///
        ///---------------------------------------///
        bottomNavigationBar: FavoriteRateContainer(
          onRatingUpdate: (newVal) {},
          onTapFavorite: (newVal) {
            log('Favorite: $newVal');
          },
        ),

        ///------------///
        ///----Body----///
        ///------------///
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///----Image
                  InkWell(
                    onTap: () {
                      Route route = MaterialPageRoute(
                        builder: (context) => MyImageZoom(
                          images: [
                            isMovie
                                ? Environment.baseImageUrl +
                                    (model as MoviesModel).posterPath
                                : Environment.baseImageUrl +
                                    (model as TvModel).posterPath
                          ],
                        ),
                      );
                      Navigator.push(context, route);
                    },
                    child: MyImage(
                      width: Sizes.width,
                      height: Sizes.height / 3,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(30),
                      image: isMovie
                          ? Environment.baseImageUrl +
                              (model as MoviesModel).posterPath
                          : Environment.baseImageUrl +
                              (model as TvModel).posterPath,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///----Rating Bar
                        RatingBarIndicator(
                          rating: isMovie
                              ? (model as MoviesModel).voteAverage
                              : (model as TvModel).voteAverage,
                          itemCount: 10,
                          itemSize: 30,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),

                        ///----Rating Text
                        MyText(
                          text: isMovie
                              ? (model as MoviesModel)
                                  .voteAverage
                                  .toStringAsFixed(1)
                              : (model as TvModel)
                                  .voteAverage
                                  .toStringAsFixed(1),
                          color: Colors.white,
                          type: TextType.medium,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),

                  ///----Title
                  MyText(
                    text: isMovie
                        ? (model as MoviesModel).title
                        : (model as TvModel).name,
                    color: Colors.white,
                    type: TextType.medium,
                  ),

                  ///----Date
                  MyText(
                    text: isMovie
                        ? (model as MoviesModel).releaseDate
                        : (model as TvModel).firstAirDate,
                    color: Colors.grey,
                    type: TextType.semiMedium,
                  ),

                  SizedBox(height: Sizes.height / 25),

                  ///----Storyline Text
                  const MyText(
                    text: 'Storyline',
                    color: Colors.white,
                    type: TextType.medium,
                  ),

                  ///----overview
                  MyText(
                    text: isMovie
                        ? (model as MoviesModel).overview
                        : (model as TvModel).overview,
                    color: Colors.grey,
                    type: TextType.semiMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
