import 'package:check_inspecao_app/models/documento_model.dart';
import 'package:check_inspecao_app/models/item_documento_model.dart';
import 'package:check_inspecao_app/services/check_inspecao_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'documentos_controller.g.dart';

class DocumentosController = _DocumentosControllerBase with _$DocumentosController;

abstract class _DocumentosControllerBase with Store {
  var _service = Modular.get<CheckInspecaoService>();

  @observable
  DocumentoModel? documentoAtual;
  @action
  novoDocumento(int usuarioId, int clienteId) async {
    documentoAtual = await _service.novoDocumento(usuarioId, clienteId);
    Modular.to.pushNamed("/Grupos");
  }

  salvarDocumento(List<ItemDocumentoModel> itens) async {
    documentoAtual?.itens = itens;
    if (documentoAtual != null) {
      DocumentoModel doc = await _service.salvarDocumento(documentoAtual!);
      return doc;
    }
  }

  getDocumentoById(int id) async {
    DocumentoModel doc = await _service.documentoById(id);
    return doc;
  }

  Future<List<DocumentoModel>> getDocumentos(int usuarioId, int clienteId) async {
    List<DocumentoModel> doc = await _service.getDocumentos(usuarioId, clienteId);
    return doc;
  }
}
