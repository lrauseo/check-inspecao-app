import 'dart:convert';

import 'package:check_inspecao_app/app/config/storage/storage.dart';
import 'package:check_inspecao_app/app/models/usuario_auth_model.dart';
import 'package:check_inspecao_app/constantes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class HttpInterceptor implements Interceptor {
  late final IStorage _storage;

  HttpInterceptor(this._storage);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("ON REQUEST CALL API -> ${options.path}");
    if (options.path != '/Usuario/AutenticarUsuario/') {
      var json = _storage.fetch(ConstsSharedPreferences.usuarioAuth);
      if (json != null) {
        final _accessToken = UsuarioAuthModel.fromJson(jsonDecode(json)).token;
        if (_accessToken != null) {
          options.headers["Authorization"] = "Bearer $_accessToken";
          // options.headers["x-request-id"] = 'request-id';
          options.headers["Content-Type"] = 'application/json';
          //options.headers["Accept"] = 'application/json';
        }
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    debugPrint("ERROR IN CALL API -> ${error.requestOptions.path} - ${error.message}");
    throw error;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("ON RESPONSE CALL API -> ${response.requestOptions.path}");
    if (response.requestOptions.path.contains('/Usuario/AutenticarUsuario/')) {
      var usuarioAuth = UsuarioAuthModel.fromJson(response.data);

      debugPrint("save the token ${usuarioAuth.toJson()}"); // TODO REMOVE THIS TO DEPLOY
      saveToken(ConstsSharedPreferences.usuarioAuth, jsonEncode(usuarioAuth.toJson()));
      debugPrint("saved token");
    }
    handler.next(response);
  }

  saveToken(String key, String value) => _storage.save(key, value);
  clear() => _storage.clear();
}
