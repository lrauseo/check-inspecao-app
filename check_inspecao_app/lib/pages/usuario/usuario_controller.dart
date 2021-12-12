import 'package:check_inspecao_app/constantes.dart';
import 'package:check_inspecao_app/models/usuario_model.dart';
import 'package:check_inspecao_app/services/check_inspecao_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'usuario_controller.g.dart';

class UsuarioController = _UsuarioControllerBase with _$UsuarioController;

abstract class _UsuarioControllerBase with Store {
  final service = Modular.get<CheckInspecaoService>();

  @observable
  UsuarioModel? usuario;

  @action
  setUsuario(UsuarioModel usuario) => this.usuario = usuario;

  @action
  Future<bool> salvarUsuario() async {
    try {
      if (this.usuario == null) return false;
      UsuarioModel usuarioModel = await service.salvarUsuario(usuario!);
      return usuarioModel != null;
    } catch (e) {
      throw e;
    }
  }
}
