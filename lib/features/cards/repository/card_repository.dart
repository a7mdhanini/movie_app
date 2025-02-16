import 'package:dartz/dartz.dart';
import 'package:flutter_movie_app/core/apis/api_failure.dart';
import 'package:flutter_movie_app/core/apis/api_helper.dart';
import 'package:flutter_movie_app/features/cards/models/card_model.dart';

class CardRepository {
  final String baseUrl = 'https://reqres.in/api/users?page=2';

  ///-----------------///
  ///----Get Cards----///
  ///-----------------///
  Future<Either<Failure, List<CardModel>>> getCards() async {
    List<CardModel> cards = [];
    Either<Failure, List<CardModel>> result = left(Failure('Unknown error'));

    await ApiHelper.request(
      method: HttpMethod.get,
      url: baseUrl,
      onSuccess: (response) {
        response.data['data'].forEach((element) {
          cards.add(CardModel.fromJson(element));
        });
        result = right(cards);
      },
      onFailure: (e) {
        result = left(Failure(e.toString()));
      },
    );

    return result;
  }

  ///-----------------///
  ///----Get Cards----///
  ///-----------------///
  Future<Either<Failure, CardModel>> addCard(CardModel card) async {
    await ApiHelper.request(
      method: HttpMethod.post,
      url: baseUrl,
      onSuccess: (response) {
        return right(card);
      },
      onFailure: (e) {
        left(e.toString());
        return Exception(e);
      },
    );

    return right(card);
  }
}
