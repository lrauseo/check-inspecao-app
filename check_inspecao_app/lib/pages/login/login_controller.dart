import 'package:check_inspecao_app/constantes.dart';
import 'package:check_inspecao_app/custom_exceptions/login_exception.dart';
import 'package:check_inspecao_app/models/usuario_auth_model.dart';
import 'package:check_inspecao_app/services/check_inspecao_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final service = Modular.get<CheckInspecaoService>();

  @action
  Future<bool> validarLogin(String usuario, String senha) async {
    try {
      UsuarioAuthModel usuarioAuth = await service.validarLogin(usuario, senha);
      if (usuarioAuth != null) {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString(ConstsSharedPreferences.usuarioAuth,
            usuarioAuth.toJson().toString());
      }
      return usuarioAuth != null;
    } on LoginException {
      return false;
    } catch (e) {
      throw e;
    }
  }
}
