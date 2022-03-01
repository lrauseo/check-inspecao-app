import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:check_inspecao_app/app/models/item_inspecao_model.dart';
import 'package:check_inspecao_app/app/models/store_base.dart';
import 'package:check_inspecao_app/app/services/check_inspecao_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'subGrupos_controller.g.dart';

class SubGruposController = _SubGruposStoreBase with _$SubGruposController;

abstract class _SubGruposStoreBase extends StoreBase with Store {
  final _service = Modular.get<CheckInspecaoService>();

  @observable
  var itens = ObservableList<ItemInspecaoModel>();
  GrupoModel? grupo;

  var txtCtrlDescricao = TextEditingController();
  var txtCtrlClassificacao = TextEditingController();

  @observable
  ItemInspecaoModel? _itemSelecionado;

  ItemInspecaoModel? get itemSelecionado => _itemSelecionado;

  set setItemSelecionado(ItemInspecaoModel value) {
    _itemSelecionado = value;
    _itemSelecionado?.grupo = grupo;
    if (_itemSelecionado != null) {
      txtCtrlDescricao.text = _itemSelecionado?.descricao ?? '';
      txtCtrlClassificacao.text = _itemSelecionado?.classificacao ?? '';
    }
  }

  @action
  buscarItens(GrupoModel grupo) async {
    this.grupo = grupo;
    if (this.grupo != null) {
      var lista = await _service.listaItensInspecao(this.grupo!.id!);
      itens.clear();
      for (var item in lista) {
        itens.add(item);
      }
    }
  }

  novoSubGrupo() {
    setItemSelecionado = ItemInspecaoModel();
  }

  @action
  salvarSubGrupo() async {
    itemSelecionado?.classificacao = txtCtrlClassificacao.text;
    itemSelecionado?.descricao = txtCtrlDescricao.text;
    if (_itemSelecionado != null) await _service.salvarSubGrupo(_itemSelecionado!);
    await buscarItens(grupo!);
  }
}
