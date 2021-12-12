import 'package:check_inspecao_app/models/grupo_model.dart';
import 'package:check_inspecao_app/services/check_inspecao_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'grupo_controller.g.dart';

class GrupoController = _GrupoControllerBase with _$GrupoController;

abstract class _GrupoControllerBase with Store {
  final _service = Modular.get<CheckInspecaoService>();
  @observable
  GrupoModel? grupoAtual;

  @action
  Future<List<GrupoModel>?> listaGrupos() async {
    try {
      var grupos = await _service.listaGrupos();
      return grupos;
    } catch (e) {
      throw e;
    }
  }

  @action
  goToItensInspecao(GrupoModel grupo) async {
    grupoAtual = grupo;
    bool voltaDocumentos = await Modular.to.pushNamed("/ItemInspecao/${grupo.id}") ?? false;
    if (voltaDocumentos) {
      Modular.to.pop(voltaDocumentos);
    }
  }
}
