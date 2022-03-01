import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:check_inspecao_app/app/services/check_inspecao_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/retry.dart';
import 'package:mobx/mobx.dart';

part 'grupo_controller.g.dart';

class GrupoController = _GrupoControllerBase with _$GrupoController;

abstract class _GrupoControllerBase with Store {
  final _service = Modular.get<CheckInspecaoService>();

  @observable
  GrupoModel? grupoAtual;
  var txtCtrlDescricao = TextEditingController();

  ObservableList<GrupoModel> grupos = ObservableList<GrupoModel>();

  @action
  listaGrupos() async {
    try {
      var value = await _service.listaGrupos();
      grupos.clear();
      if (value != null) {
        for (var item in value) {
          grupos.add(item);
        }
      }

      //return grupos;
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

  @action
  Future<GrupoModel?> salvarGrupo() async {
    if (grupoAtual != null) {
      grupoAtual?.descricao = txtCtrlDescricao.text;
      var grupoSalvo = await _service.salvarGrupo(grupoAtual!);
      grupoAtual = null;
      listaGrupos();
      return grupoSalvo;
    }
  }

  @action
  novoGrupo() async {
    grupoAtual = null;
    txtCtrlDescricao.clear();
  }
}
