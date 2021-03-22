import 'dart:convert';
import 'dart:io';
import 'package:check_inspecao_app/constantes.dart';
import 'package:check_inspecao_app/custom_exceptions/login_exception.dart';
import 'package:check_inspecao_app/models/documento_model.dart';
import 'package:check_inspecao_app/models/grupo_model.dart';
import 'package:check_inspecao_app/models/item_inspecao_model.dart';
import 'package:check_inspecao_app/models/usuario_auth_model.dart';
import 'package:http/http.dart' as http;

class CheckInspecaoService {
  final String _autenticarUsuario = "/Usuario/AutenticarUsuario/";
  Future<UsuarioAuthModel> validarLogin(String usuario, String senha) async {
    try {
      var url = Uri.https(Constantes.baseUrl, _autenticarUsuario,
          {'login': usuario, 'senha': senha});
      var response = await http.post(url
          // , headers: {
          //   'content-type': 'application/json',
          //   "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          //   "Access-Control-Allow-Credentials":
          //       'true', // Required for cookies, authorization headers with HTTPS
          //   "Access-Control-Allow-Headers":
          //       "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          //   "Access-Control-Allow-Methods": "POST, OPTIONS"
          // }
          );
      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        print("UsuarioAutenticado...");
        var usuarioAuth = UsuarioAuthModel.fromJson(json);
        return usuarioAuth;
      } else {
        throw LoginException("Usuario Inválido");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<DocumentoModel> novoDocumento(int usuarioId, int clientId) async {
    final String _novoDocumento = "/Documento/NovoDocumento/";
    try {
      var url = Uri.https(Constantes.baseUrl, _novoDocumento, {
        'usuarioId': usuarioId.toString(),
        'clienteId': clientId.toString()
      });
      var response = await http.post(url);
      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        print("Novo Documento criado...");
        var documento = DocumentoModel.fromJson(json);
        return documento;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<GrupoModel>> listaGrupos() async {
    final String _grupo = "/Grupo/";
    try {
      var url = Uri.https(Constantes.baseUrl, _grupo);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Iterable json = jsonDecode(response.body);
        print("Busca grupos...");
        var grupos = <GrupoModel>[];
        json.forEach((v) {
          grupos.add(GrupoModel.fromJson(v));
        });
        return grupos;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  listaItensInspecao(int grupoId) async {
    final String _itemInspecao = "/Grupo/BuscaItensInspecao/";
    try {
      var url = Uri.https(
          Constantes.baseUrl, _itemInspecao, {'grupoId': grupoId.toString()});
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Iterable json = jsonDecode(response.body);
        print("Busca itens grupos...");
        var itens = <ItemInspecaoModel>[];
        json.forEach((v) {
          itens.add(ItemInspecaoModel.fromJson(v));
        });
        return itens;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  salvarDocumento(DocumentoModel documentoAtual) async {
    final String _salvarDocumento = "/Documento/SalvarDocumeto/";
    try {
      var url = Uri.https(Constantes.baseUrl, _salvarDocumento);
      // print(documentoAtual.toJson().toString());
      var param = jsonEncode(documentoAtual.toJson(true));
      var response = await http.post(url,
          body: param,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        print("Documento Salvo...");
        return DocumentoModel.fromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  documentoById(int documentoId) async {
    final String _documentoById = "/Documento/GetDocumentoById/";
    try {
      var url = Uri.https(Constantes.baseUrl, _documentoById,
          {'documentoId': documentoId.toString()});
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        print("Busca documento...");
        return DocumentoModel.fromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  getDocumentos(int usuarioId, int clienteId) async {
    final String _documentos = "/Documento/GetDocumentos/";
    try {
      var url = Uri.https(Constantes.baseUrl, _documentos, {
        'usuarioId': usuarioId.toString(),
        'clienteId': clienteId.toString()
      });
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Iterable json = jsonDecode(response.body);
        print("Busca documentos...");
        var itens = <DocumentoModel>[];
        json.forEach((v) {
          itens.add(DocumentoModel.fromJson(v));
        });
        return itens;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }
}
