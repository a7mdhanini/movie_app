import 'package:dartz/dartz.dart';
import 'package:flutter_movie_app/core/apis/api_failure.dart';
import 'package:flutter_movie_app/core/apis/api_helper.dart';
import 'package:flutter_movie_app/features/discover/models/movies_model.dart';
import 'package:flutter_movie_app/features/discover/models/tv_model.dart';

class DiscoverRepository {
  ///------------------///
  ///----Get Movies----///
  ///------------------///
  Future<Either<Failure, List<MoviesModel>>> getMovies() async {
    String url =
        'discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc';

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

  ///--------------------///
  ///----Get Tv Shows----///
  ///--------------------///
  Future<Either<Failure, List<TvModel>>> getTvShows() async {
    String url =
        'discover/tv?include_adult=false&include_null_first_air_dates=false&language=en-US&page=1&sort_by=popularity.desc';

    List<TvModel> movies = [];
    Either<Failure, List<TvModel>> result = left(Failure('Unknown error'));

    await ApiHelper.request(
      method: HttpMethod.get,
      url: url,
      onSuccess: (response) {
        response.data['results'].forEach((element) {
          movies.add(TvModel.fromJson(element));
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
  // ///-----------------///
  // ///----Get Cards----///
  // ///-----------------///
  // Future<Either<Failure, CardModel>> addCard(CardModel card) async {
  //   await ApiHelper.request(
  //     method: HttpMethod.post,
  //     url: baseUrl,
  //     onSuccess: (response) {
  //       return right(card);
  //     },
  //     onFailure: (e) {
  //       left(e.toString());
  //       return Exception(e);
  //     },
  //   );

  //   return right(card);
  // }

