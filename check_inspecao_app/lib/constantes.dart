import 'package:flutter/foundation.dart';

enum Httptype { http, https }

class Constantes {
  static const _urlRemote = "checkinspecao-api-desenv.azurewebsites.net";
  static const _urlLocal = "192.168.0.5:5002";
  static const baseUrl = kDebugMode ? _urlRemote : _urlRemote;
  static const Httptype httpType = kDebugMode ? Httptype.https : Httptype.https;
}

class ConstsSharedPreferences {
  static const usuarioAuth = "usuarioAuth";
  static const versao = "versao";
  static const perfil = 'perfil-id';
}

class Criptografia {
  static const key = "0Aa%%0pVsqh9BAab";
  static const privateKey = "sqh9BAab0Aa%%0pV";
}
