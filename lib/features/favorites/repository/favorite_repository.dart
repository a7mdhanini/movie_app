import 'package:dartz/dartz.dart';
import 'package:flutter_movie_app/core/apis/api_failure.dart';
import 'package:flutter_movie_app/core/apis/api_helper.dart';
import 'package:flutter_movie_app/core/apis/api_paths.dart';
import 'package:flutter_movie_app/features/discover/models/movies_model.dart';

class FavoriteRepository {
  ///------------------///
  ///----Get Movies----///
  ///------------------///
  Future<Either<Failure, List<MoviesModel>>> getFavorites() async {
    String url = ApiPaths.topRatedMoviesApi;

    List<MoviesModel> movies = [];
    Either<Failure, List<MoviesModel>> result = left(Failure('Unknown error'));

    await ApiHelper.request(
      method: HttpMethod.get,
      url: url,
      onSuccess: (response) {
        response.data['results'].forEach((element) {
          movies.add(MoviesModel.fromJson(element));
        });
        result = right(movies);
      },
      onFailure: (e) {
        result = left(Failure(e.toString()));
      },
    );

    return result;
  }
}