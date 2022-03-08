import 'package:check_inspecao_app/app/custom_exceptions/exception_app.dart';
import 'package:check_inspecao_app/app/models/perfil_usuario_model.dart';
import 'package:check_inspecao_app/app/models/store_base.dart';
import 'package:check_inspecao_app/app/services/check_inspecao_service.dart';
import 'package:check_inspecao_app/constantes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'perfil_controller.g.dart';

class PerfilController = _PerfilControllerBase with _$PerfilController;

abstract class _PerfilControllerBase with Store {
  final _service = Modular.get<CheckInspecaoService>();

  @observable
  ExceptionApp? exceptionApp;
  @observable
  bool loading = false;
  @action
  setLoading(bool value) => loading = value;

  ObservableList<PerfilUsuarioModel> perfis = ObservableList<PerfilUsuarioModel>();

  @action
  buscarPerfis() async {
    List<PerfilUsuarioModel> listaPerfil;
    listaPerfil = await _service.getPerfis();
    perfis.clear();
    for (var e in listaPerfil) {
      perfis.add(e);
    }
  }

  goToHome(int perfilId) {
    SharedPreferences.getInstance().then((value) {
      value.setInt(ConstsSharedPreferences.perfil, perfilId);
      Modular.to.pushReplacementNamed('/Documentos');
    });
  }
}
