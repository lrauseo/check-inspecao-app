import 'dart:convert';

import 'package:check_inspecao_app/app/custom_exceptions/exception_app.dart';
import 'package:check_inspecao_app/app/custom_exceptions/login_exception.dart';
import 'package:check_inspecao_app/app/models/store_base.dart';
import 'package:check_inspecao_app/app/models/usuario_auth_model.dart';
import 'package:check_inspecao_app/app/modules/usuario/usuario_controller.dart';
import 'package:check_inspecao_app/app/services/check_inspecao_service.dart';
import 'package:check_inspecao_app/constantes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final service = Modular.get<CheckInspecaoService>();
  final _usuarioController = Modular.get<UsuarioController>();

  final usuarioCtrl = TextEditingController();

  final senhaTxtCtrl = TextEditingController();

  @observable
  ExceptionApp? exceptionApp;
  @observable
  bool loading = false;
  @action
  setLoading(bool value) => loading = value;

  @action
  Future<bool> validarLogin() async {
    try {
      setLoading(true);
      UsuarioAuthModel usuarioAuth = await service.validarLogin(usuarioCtrl.text, senhaTxtCtrl.text);
      if (usuarioAuth != null) {
        var prefs = await SharedPreferences.getInstance();
        await prefs.remove(ConstsSharedPreferences.usuarioAuth);
        prefs.setString(ConstsSharedPreferences.usuarioAuth, jsonEncode(usuarioAuth.toJson()));
      }
      setLoading(false);
      return usuarioAuth != null;
    } on LoginException {
      exceptionApp = ExceptionApp("Usuario/Senha inválidos");
      setLoading(false);
      return false;
    } catch (e) {
      exceptionApp = ExceptionApp(e.toString());
      setLoading(false);
      throw e;
    }
  }
}
