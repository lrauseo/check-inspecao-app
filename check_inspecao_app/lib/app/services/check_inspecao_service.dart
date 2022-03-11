import 'dart:convert';
import 'dart:io';
import 'package:check_inspecao_app/app/custom_exceptions/http_badrequest_exception_app.dart';
import 'package:check_inspecao_app/app/custom_exceptions/login_exception.dart';
import 'package:check_inspecao_app/app/models/documento_model.dart';
import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:check_inspecao_app/app/models/item_inspecao_model.dart';
import 'package:check_inspecao_app/app/models/perfil_usuario_model.dart';
import 'package:check_inspecao_app/app/models/questionario_formulario_model.dart';
import 'package:check_inspecao_app/app/models/usuario_auth_model.dart';
import 'package:check_inspecao_app/app/models/usuario_model.dart';
import 'package:check_inspecao_app/constantes.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' as pkgDebug;
import 'package:shared_preferences/shared_preferences.dart';

class CheckInspecaoService {
  late final DioForNative _dio;

  int? _perfilId;

  CheckInspecaoService(this._dio);

  final String _autenticarUsuario = "/Usuario/AutenticarUsuario/";
  Future<UsuarioAuthModel> validarLogin(String usuario, String senha) async {
    try {
      Uri url;
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String key = stringToBase64.encode(Criptografia.key);
      String iv = stringToBase64.encode(Criptografia.privateKey);

      final encrypter = Encrypter(AES(Key.fromBase64(key), mode: AESMode.cbc, padding: 'PKCS7'));

      final encrypted = encrypter.encrypt(senha, iv: IV.fromBase64(iv));
      // final decrypted = encrypter.decrypt(encrypted, iv: IV.fromBase64(iv));

      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _autenticarUsuario, {'login': usuario, 'senha': encrypted.base64});
      } else {
        url =
            Uri.https(Constantes.baseUrl, _autenticarUsuario, {'login': usuario, 'senha': encrypted.base64});
      }

      var response = await _dio.post(url.toString().toString()
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
        pkgDebug.debugPrint("UsuarioAutenticado...");
        var usuarioAuth = UsuarioAuthModel.fromJson(response.data);
        return usuarioAuth;
      } else {
        throw LoginException("Usuario Inválido");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<DocumentoModel?> novoDocumento(int clientId) async {
    const String _novoDocumento = "/Documento/NovoDocumento/";
    try {
      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _novoDocumento,
            {'clienteId': clientId.toString(), 'perfilUsuarioId': _perfilId.toString()});
      } else {
        url = Uri.https(Constantes.baseUrl, _novoDocumento,
            {'clienteId': clientId.toString(), 'perfilUsuarioId': _perfilId.toString()});
      }
      var response = await _dio.post(url.toString());
      if (response.statusCode == 200) {
        pkgDebug.debugPrint("Novo Documento criado...");
        var documento = DocumentoModel.fromJson(response.data);
        return documento;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<GrupoModel>?> listaGrupos() async {
    const String _grupo = "/Grupo/";
    try {
      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _grupo);
      } else {
        url = Uri.https(Constantes.baseUrl, _grupo);
      }

      var response = await _dio.get(url.toString());
      if (response.statusCode == 200) {
        pkgDebug.debugPrint("Busca grupos...");
        var grupos = <GrupoModel>[];
        for (var v in response.data) {
          grupos.add(GrupoModel.fromJson(v));
        }
        return grupos;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<GrupoModel?> salvarGrupo(GrupoModel grupo) async {
    const String _grupo = "/Grupo/";
    try {
      var param = jsonEncode(grupo.toJson());

      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _grupo);
      } else {
        url = Uri.https(Constantes.baseUrl, _grupo);
      }
      var response = await _dio.post(
        url.toString(),
        data: param,
      );
      if (response.statusCode == 200) {
        return GrupoModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  listaItensInspecao(int grupoId) async {
    const String _itemInspecao = "/Grupo/BuscaItensInspecao/";
    try {
      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _itemInspecao, {'grupoId': grupoId.toString()});
      } else {
        url = Uri.https(Constantes.baseUrl, _itemInspecao, {'grupoId': grupoId.toString()});
      }
      var response = await _dio.get(url.toString());
      if (response.statusCode == 200) {
        pkgDebug.debugPrint("Busca itens grupos...");
        var itens = <ItemInspecaoModel>[];
        for (var v in response.data) {
          itens.add(ItemInspecaoModel.fromJson(v));
        }

        return itens;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  salvarDocumento(DocumentoModel documentoAtual) async {
    const String _salvarDocumento = "/Documento/SalvarDocumeto/";
    try {
      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _salvarDocumento);
      } else {
        url = Uri.https(Constantes.baseUrl, _salvarDocumento);
      }
      // pkgDebug.debugPrint(documentoAtual.toJson().toString());
      var param = jsonEncode(documentoAtual.toJson(true));
      var response = await _dio.post(url.toString(), data: param);
      if (response.statusCode == 200) {
        pkgDebug.debugPrint("Documento Salvo...");
        return DocumentoModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  salvarUsuario(UsuarioModel usuario) async {
    const String _salvarUsuario = "/Usuario/SalvarUsuario/";
    try {
      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _salvarUsuario);
      } else {
        url = Uri.https(Constantes.baseUrl, _salvarUsuario);
      }
      // pkgDebug.debugPrint(documentoAtual.toJson().toString());
      var param = jsonEncode(usuario.toJson());
      var response = await _dio.post(url.toString(), data: param);
      if (response.statusCode == 200) {
        pkgDebug.debugPrint("Usuario Salvo...");
        return UsuarioModel.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw e;
    }
  }

  criarUsuario(UsuarioModel usuario) async {
    const String _salvarUsuario = "/Usuario/CriarUsuario/";
    try {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String key = stringToBase64.encode(Criptografia.key);
      String iv = stringToBase64.encode(Criptografia.privateKey);

      final encrypter = Encrypter(AES(Key.fromBase64(key), mode: AESMode.cbc, padding: 'PKCS7'));

      final encrypted = encrypter.encrypt(usuario.senha!, iv: IV.fromBase64(iv));
      usuario.senha = encrypted.base64;

      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _salvarUsuario);
      } else {
        url = Uri.https(Constantes.baseUrl, _salvarUsuario);
      }
      // pkgDebug.debugPrint(documentoAtual.toJson().toString());
      var param = jsonEncode(usuario.toJson());
      var response = await _dio.post(url.toString(), data: param);
      if (response.statusCode == 200) {
        pkgDebug.debugPrint("Usuario Salvo...");
        return UsuarioModel.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw e;
    }
  }

  documentoById(int documentoId) async {
    const String _documentoById = "/Documento/GetDocumentoById/";
    try {
      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _documentoById, {'documentoId': documentoId.toString()});
      } else {
        url = Uri.https(Constantes.baseUrl, _documentoById, {'documentoId': documentoId.toString()});
      }
      var response = await _dio.get(url.toString());
      if (response.statusCode == 200) {
        pkgDebug.debugPrint("Busca documento...");
        return DocumentoModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  getDocumentos(int clienteId) async {
    const String _documentos = "/Documento/GetDocumentos/";
    try {
      // var prefs = await SharedPreferences.getInstance();
      // String usuarioAuthJson = prefs.getString(ConstsSharedPreferences.usuarioAuth)!;
      // Map<String, dynamic> json = jsonDecode(usuarioAuthJson);
      // var usuarioAuth = UsuarioAuthModel.fromJson(json);

      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _documentos, {'clienteId': clienteId.toString()});
      } else {
        url = Uri.https(Constantes.baseUrl, _documentos, {'clienteId': clienteId.toString()});
      }
      var response = await _dio.get(url.toString());
      if (response.statusCode == 200) {
        pkgDebug.debugPrint("Busca documentos...");
        var itens = <DocumentoModel>[];
        response.data.forEach((v) {
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

  Future<List<PerfilUsuarioModel>> getPerfis() async {
    const String _documentos = "/Usuario/Perfis/";
    try {
      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _documentos);
      } else {
        url = Uri.https(Constantes.baseUrl, _documentos);
      }
      var response = await _dio.get(
        url.toString(),
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        pkgDebug.debugPrint("Busca de perfis...");
        var itens = <PerfilUsuarioModel>[];
        for (var v in response.data!) {
          itens.add(PerfilUsuarioModel.fromJson(v));
        }
        return itens;
      } else {
        if (pkgDebug.kDebugMode) {
          pkgDebug.debugPrint(response.statusMessage);
        }
        return <PerfilUsuarioModel>[];
      }
    } catch (e) {
      throw e;
    }
  }

  Future<ItemInspecaoModel?> salvarSubGrupo(ItemInspecaoModel itemInspecao) async {
    const String _subgrupo = "/Grupo/SalvarItensInspecao/";
    try {
      var param = jsonEncode(itemInspecao.toJson());

      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _subgrupo);
      } else {
        url = Uri.https(Constantes.baseUrl, _subgrupo);
      }
      var response = await _dio.post(
        url.toString(),
        data: param,
      );
      if (response.statusCode == 200) {
        return ItemInspecaoModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<QuestionarioFormularioModel>> getQuestionarios() async {
    const String _documentos = "/Documento/QuestionarioFormulario/";
    try {
      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _documentos);
      } else {
        url = Uri.https(Constantes.baseUrl, _documentos);
      }
      var response = await _dio.get(url.toString());
      if (response.statusCode == 200) {
        pkgDebug.debugPrint("Busca de Questionarios...");
        var itens = <QuestionarioFormularioModel>[];
        for (var v in response.data) {
          itens.add(QuestionarioFormularioModel.fromJson(v));
        }
        return itens;
      } else {
        return <QuestionarioFormularioModel>[];
      }
    } catch (e) {
      throw e;
    }
  }

  Future<QuestionarioFormularioModel?> salvarQuestionarioFormmulario(
      QuestionarioFormularioModel questionario) async {
    const String _questionario = "/Documento/QuestionarioFormulario/";
    try {
      var param = jsonEncode(questionario.toJson());

      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _questionario);
      } else {
        url = Uri.https(Constantes.baseUrl, _questionario);
      }
      var response = await _dio.post(
        url.toString(),
        data: param,
      );
      if (response.statusCode == HttpStatus.ok) {
        return QuestionarioFormularioModel.fromJson(response.data);
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw HttpBadRequestExceptionApp(response.statusMessage, details: response.toString());
      }
    } catch (e) {
      throw e;
    }
  }

  buscaItemInspecaoByFormulario(int formularioId) async {
    const String _itemInspecao = "/Documento/ItemInspecaoByFormulario/";
    try {
      Uri url;
      if (Constantes.httpType == Httptype.http) {
        url = Uri.http(Constantes.baseUrl, _itemInspecao, {'formularioId': formularioId.toString()});
      } else {
        url = Uri.https(Constantes.baseUrl, _itemInspecao, {'formularioId': formularioId.toString()});
      }
      var response = await _dio.get(url.toString());
      if (response.statusCode == 200) {
        pkgDebug.debugPrint("Busca itens inspeção por fomulario...");
        var itens = <ItemInspecaoModel>[];
        for (var v in response.data) {
          itens.add(ItemInspecaoModel.fromJson(v));
        }
        return itens;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }
}
