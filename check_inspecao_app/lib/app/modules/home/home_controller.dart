import 'dart:convert';

import 'package:check_inspecao_app/app/custom_exceptions/exception_app.dart';
import 'package:check_inspecao_app/app/models/documento_model.dart';
import 'package:check_inspecao_app/app/models/item_documento_model.dart';
import 'package:check_inspecao_app/app/models/store_base.dart';
import 'package:check_inspecao_app/app/models/usuario_auth_model.dart';
import 'package:check_inspecao_app/constantes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobx/mobx.dart';
import 'package:check_inspecao_app/app/services/check_inspecao_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final _service = Modular.get<CheckInspecaoService>();
  @observable
  ExceptionApp? exceptionApp;
  @observable
  bool loading = false;
  @action
  setLoading(bool value) => loading = value;
  @observable
  DocumentoModel? documentoAtual;
  @action
  novoDocumento(int clienteId) async {
    documentoAtual = await _service.novoDocumento(clienteId);
    var formularioSelecionado = await Modular.to.pushNamed<int?>("/Questionarios/Buscar");
    await Modular.to.pushNamed("/ItemInspecao/$formularioSelecionado") ?? false;
    // if (voltaDocumentos) {
    //   Modular.to.pop(voltaDocumentos);
    // }
  }

  salvarDocumento() async {
    if (documentoAtual != null) {
      DocumentoModel doc = await _service.salvarDocumento(documentoAtual!);
      return doc;
    }
  }

  getDocumentoById(int id) async {
    DocumentoModel doc = await _service.documentoById(id);
    return doc;
  }

  Future<List<DocumentoModel>> getDocumentos(int clienteId) async {
    var prefs = await SharedPreferences.getInstance();
    String? usuarioAuthJson = prefs.getString(ConstsSharedPreferences.usuarioAuth);
    if (usuarioAuthJson == null) return <DocumentoModel>[];
    //var usuarioAuth = UsuarioAuthModel.fromJson(jsonDecode(usuarioAuthJson));
    List<DocumentoModel> doc = await _service.getDocumentos(clienteId);
    return doc;
  }
}
