import 'package:flutter_movie_app/core/apis/api_test_map.dart';

class CardModel {
  final int id;
  final String cardNumber;
  final String cardType;
  final String expirationDate;

  CardModel({
    this.id = 0,
    this.cardNumber = '',
    this.cardType = '',
    this.expirationDate = '',
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: testMap(json, 'id', 0),
      cardNumber: testMap(json, 'email', ''),
      cardType: testMap(json, 'first_name', ''),
      expirationDate: testMap(json, 'last_name', ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'cardType': cardType,
      'expirationDate': expirationDate,
    };
  }
}
