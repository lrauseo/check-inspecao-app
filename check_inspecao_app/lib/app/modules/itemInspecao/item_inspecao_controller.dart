import 'dart:typed_data';
import 'package:check_inspecao_app/app/custom_exceptions/exception_app.dart';
import 'package:check_inspecao_app/app/models/documento_model.dart';
import 'package:check_inspecao_app/app/models/foto_model.dart';
import 'package:check_inspecao_app/app/models/item_documento_model.dart';
import 'package:check_inspecao_app/app/models/item_inspecao_model.dart';
import 'package:check_inspecao_app/app/models/opcao_inspecao_enum.dart';
import 'package:check_inspecao_app/app/modules/grupo/grupo_controller.dart';
import 'package:check_inspecao_app/app/services/check_inspecao_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'item_inspecao_controller.g.dart';

class ItemInspecaoController = _ItemInspecaoControllerBase with _$ItemInspecaoController;

abstract class _ItemInspecaoControllerBase with Store {
  @observable
  ExceptionApp? exceptionApp;
  @observable
  bool loading = false;
  @action
  setLoading(bool value) => loading = value;

  final _service = Modular.get<CheckInspecaoService>();

  final _grupoController = Modular.get<GrupoController>();
  @observable
  DocumentoModel? documentoAtual;

  @action
  listaItens(int? formularioId) async {
    try {
      if (formularioId == null && documentoAtual != null) return;
      setLoading(true);
      var itens = await _service.buscaItemInspecaoByFormulario(formularioId!);

      criaItemDocumento(itens);

      setLoading(false);
      documentoAtual = documentoAtual;
    } catch (e) {
      setLoading(false);
      throw e;
    }
  }

  @action
  setDocumentoAtual(DocumentoModel? doc) {
    documentoAtual = doc;
  }

  @action
  criaItemDocumento(List<ItemInspecaoModel> itens) {
    for (var element in itens) {
      // element.grupo = _grupoController.grupoAtual;
      documentoAtual?.itens?.add(ItemDocumentoModel(id: 0, itemInspecao: element, documento: documentoAtual));
    }
    documentoAtual = documentoAtual;
  }

  @action
  addItemDocumento(ItemDocumentoModel item) {
    var it =
        documentoAtual?.itens?.firstWhere((element) => element.itemInspecao!.id == item.itemInspecao!.id);
    int? idx = documentoAtual?.itens?.indexOf(it!);
    if (it != null) documentoAtual?.itens?.remove(it);
    documentoAtual?.itens?.insert(idx!, item);
    documentoAtual = documentoAtual;
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

  validaItens() {
    if (documentoAtual?.itens == null) return <int, ItemDocumentoModel>{};
    var listaErros = <int, ItemDocumentoModel>{};
    for (var item in documentoAtual!.itens!) {
      if (item.nao != true && item.sim != true && item.naoObservado != true && item.naoSeAplica != true) {
        listaErros[documentoAtual!.itens!.indexOf(item)] = item;
      }
    }
    if (listaErros.isNotEmpty) {
      exceptionApp = ExceptionApp("Existem itens não marcados !");
    }
  }
}
