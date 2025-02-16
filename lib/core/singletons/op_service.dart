import 'dart:async';

class OPService {
  static final OPService _oPService = OPService._internal();

  dynamic itoken;
  dynamic dtoken;
  dynamic wtoken;
  String userId = '';
  String? walletIdentifier;
  String? countryCode = "JO";
  String? factorType;
  String? sessionKey = "";
  String? cQRAPI;
  dynamic image64basePortraite;
  dynamic idFaceimage64base;

  StreamController<int> streamController = StreamController<int>();
  factory OPService() {
    return _oPService;
  }

  OPService._internal();
}

final oPService = OPService();
dynamic oPServiceSearch = OPService();
