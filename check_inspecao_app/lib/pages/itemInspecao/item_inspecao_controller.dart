import 'dart:typed_data';

import 'package:check_inspecao_app/models/documento_model.dart';
import 'package:check_inspecao_app/models/foto_model.dart';
import 'package:check_inspecao_app/models/item_documento_model.dart';
import 'package:check_inspecao_app/models/item_inspecao_model.dart';
import 'package:check_inspecao_app/models/opcao_inspecao_enum.dart';
import 'package:check_inspecao_app/pages/grupo/grupo_controller.dart';
import 'package:check_inspecao_app/services/check_inspecao_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'item_inspecao_controller.g.dart';

class ItemInspecaoController = _ItemInspecaoControllerBase with _$ItemInspecaoController;

abstract class _ItemInspecaoControllerBase with Store {
  var _service = Modular.get<CheckInspecaoService>();
  var itensDocumento = ObservableList<ItemDocumentoModel>();
  var _grupoController = Modular.get<GrupoController>();
  @observable
  DocumentoModel? documentoAtual;
  @observable
  ItemDocumentoModel? itemSelecionado;

  Future<List<ItemDocumentoModel>> listaItens(int grupoId) async {
    try {
      var itens = await _service.listaItensInspecao(grupoId);
      if (this.documentoAtual?.itens?.length == 0) {
        criaItemDocumento(itens);
      } else {
        this.itensDocumento = this.documentoAtual!.itens!.asObservable();
      }
      return this.itensDocumento.toList();
    } catch (e) {
      throw e;
    }
  }

  @action
  setDocumentoAtual(DocumentoModel? doc) {
    this.documentoAtual = doc;
  }

  @action
  criaItemDocumento(List<ItemInspecaoModel> itens) {
    // var lista = <ItemDocumentoModel>[];
    itensDocumento.clear();
    var itensExibicao =
        documentoAtual?.itens?.where((i) => i.itemInspecao?.grupo?.id == _grupoController.grupoAtual!.id);
    if (documentoAtual!.itens!.length > 0 && itensExibicao!.length > 0) {
      itensExibicao.forEach((element) {
        element.documento = this.documentoAtual;
        itensDocumento.add(element);
      });
    } else {
      itens.forEach((element) {
        element.grupo = _grupoController.grupoAtual;
        itensDocumento.add(ItemDocumentoModel(id: 0, itemInspecao: element, documento: this.documentoAtual));
      });
      this.documentoAtual?.itens = this.itensDocumento;
    }
  }

  @action
  addItemDocumento(ItemDocumentoModel item) {
    var it = itensDocumento.firstWhere((element) => element.itemInspecao!.id == item.itemInspecao!.id);
    int idx = itensDocumento.indexOf(it);
    if (it != null) itensDocumento.remove(it);
    itensDocumento.insert(idx, item);
  }

  addFoto(ItemDocumentoModel item, Uint8List imageStream) async {
    if (item.fotos == null) item.fotos = <FotoModel>[];
    item.fotos?.add(FotoModel(id: 0, arquivo: imageStream));
    addItemDocumento(item);
  }

  excluirFoto(ItemDocumentoModel item, FotoModel foto) {
    var ft = item.fotos?.firstWhere((element) => element.id == foto.id);
    if (ft != null) item.fotos?.remove(ft);
    addItemDocumento(item);
  }

  @action
  setOpcaoInspecao(ItemDocumentoModel item, OpcaoInspecao opcao) {
    switch (opcao) {
      case OpcaoInspecao.sim:
        {
          item.sim = true;
          item.nao = !item.sim!;
          item.naoObservado = !item.sim!;
          item.naoSeAplica = !item.sim!;
        }
        break;
      case OpcaoInspecao.nao:
        {
          item.nao = true;
          item.sim = !item.nao!;
          item.naoObservado = !item.nao!;
          item.naoSeAplica = !item.nao!;
        }
        break;
      case OpcaoInspecao.naoSeAplica:
        {
          item.naoSeAplica = true;
          item.sim = !item.naoSeAplica!;
          item.nao = !item.naoSeAplica!;
          item.naoObservado = !item.naoSeAplica!;
        }
        break;
      case OpcaoInspecao.naoObservado:
        {
          item.naoObservado = true;
          item.sim = !item.naoObservado!;
          item.nao = !item.naoObservado!;
          item.naoSeAplica = !item.naoObservado!;
        }
        break;
      default:
    }
    addItemDocumento(item);
  }

  Map<int, ItemDocumentoModel> validaItens(List<ItemDocumentoModel> itens) {
    var listaErros = Map<int, ItemDocumentoModel>();
    for (var item in itens) {
      if (item.nao != true && item.sim != true && item.naoObservado != true && item.naoSeAplica != true)
        listaErros[itens.indexOf(item)] = item;
    }
    return listaErros;
  }
}
