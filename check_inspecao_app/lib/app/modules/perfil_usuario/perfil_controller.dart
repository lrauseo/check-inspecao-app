import 'package:check_inspecao_app/app/models/perfil_usuario_model.dart';
import 'package:check_inspecao_app/app/services/check_inspecao_service.dart';
import 'package:check_inspecao_app/constantes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'perfil_controller.g.dart';

class PerfilController = _PerfilControllerBase with _$PerfilController;

abstract class _PerfilControllerBase with Store {
  final _service = Modular.get<CheckInspecaoService>();

  ObservableList<PerfilUsuarioModel> perfis = ObservableList<PerfilUsuarioModel>();

  @action
  buscarPerfis() {
    List<PerfilUsuarioModel> listaPerfil;
    _service.getPerfis().then((value) {
      listaPerfil = value;
      perfis.clear();
      for (var e in listaPerfil) {
        perfis.add(e);
      }
    });
  }

  goToHome(int perfilId) {
    SharedPreferences.getInstance().then((value) {
      value.setInt(ConstsSharedPreferences.perfil, perfilId);
      Modular.to.pushReplacementNamed('/Documentos');
    });
  }
}
