import 'dart:convert';
import 'dart:io';
import 'package:check_inspecao_app/app/custom_exceptions/login_exception.dart';
import 'package:check_inspecao_app/app/models/documento_model.dart';
import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:check_inspecao_app/app/models/item_inspecao_model.dart';
import 'package:check_inspecao_app/app/models/perfil_usuario_model.dart';
import 'package:check_inspecao_app/app/models/usuario_auth_model.dart';
import 'package:check_inspecao_app/app/models/usuario_model.dart';
import 'package:check_inspecao_app/constantes.dart';
import 'package:encrypt/encrypt.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckInspecaoService {
  late SharedPreferences _preferences;
  late UsuarioAuthModel _usuarioAuth;
  int? _perfilId;
  CheckInspecaoService() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
      String? usuarioAuthJson = _preferences.getString(ConstsSharedPreferences.usuarioAuth);
      if (usuarioAuthJson != null) {
        Map<String, dynamic> json = jsonDecode(usuarioAuthJson);
        _usuarioAuth = UsuarioAuthModel.fromJson(json);
        _perfilId = _preferences.getInt(ConstsSharedPreferences.perfil);
      }
    });
  }
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
        Map<String, dynamic> json = jsonDecode(response.body);
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

  Future<DocumentoModel?> novoDocumento(int clientId) async {
    const String _novoDocumento = "/Documento/NovoDocumento/";
    try {
      var url = Uri.http(Constantes.baseUrl, _novoDocumento,
          {'clienteId': clientId.toString(), 'perfilUsuarioId': _perfilId.toString()});
      var response = await http.post(url, headers: {'Authorization': 'Bearer ${_usuarioAuth.token}'});
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
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

  Future<List<GrupoModel>?> listaGrupos() async {
    const String _grupo = "/Grupo/";
    try {
      var url = Uri.http(Constantes.baseUrl, _grupo);
      var response = await http.get(url, headers: {'Authorization': 'Bearer ${_usuarioAuth.token}'});
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
    const String _itemInspecao = "/Grupo/BuscaItensInspecao/";
    try {
      var url = Uri.http(Constantes.baseUrl, _itemInspecao, {'grupoId': grupoId.toString()});
      var response = await http.get(url, headers: {'Authorization': 'Bearer ${_usuarioAuth.token}'});
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
    const String _salvarDocumento = "/Documento/SalvarDocumeto/";
    try {
      var url = Uri.http(Constantes.baseUrl, _salvarDocumento);
      // print(documentoAtual.toJson().toString());
      var param = jsonEncode(documentoAtual.toJson(true));
      var response = await http.post(url, body: param, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer ${_usuarioAuth.token}'
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        print("Documento Salvo...");
        return DocumentoModel.fromJson(json);
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
      var url = Uri.http(Constantes.baseUrl, _salvarUsuario);
      // print(documentoAtual.toJson().toString());
      var param = jsonEncode(usuario.toJson());
      var response = await http.post(url, body: param, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer ${_usuarioAuth.token}'
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        print("Usuario Salvo...");
        return UsuarioModel.fromJson(json);
      } else {
        throw Exception(response.body);
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
      var url = Uri.http(Constantes.baseUrl, _salvarUsuario);
      // print(documentoAtual.toJson().toString());
      var param = jsonEncode(usuario.toJson());
      var response = await http.post(url, body: param, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer ${_usuarioAuth.token}'
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        print("Usuario Salvo...");
        return UsuarioModel.fromJson(json);
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw e;
    }
  }

  documentoById(int documentoId) async {
    const String _documentoById = "/Documento/GetDocumentoById/";
    try {
      var url = Uri.http(Constantes.baseUrl, _documentoById, {'documentoId': documentoId.toString()});
      var response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer ${_usuarioAuth.token}'
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        print("Busca documento...");
        return DocumentoModel.fromJson(json);
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

      var url = Uri.http(Constantes.baseUrl, _documentos, {'clienteId': clienteId.toString()});
      var response = await http.get(url, headers: {'Authorization': 'Bearer ${_usuarioAuth.token}'});
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

  Future<List<PerfilUsuarioModel>> getPerfis() async {
    const String _documentos = "/Usuario/Perfis/";
    try {
      var url = Uri.http(Constantes.baseUrl, _documentos);
      var response = await http.get(url, headers: {'Authorization': 'Bearer ${_usuarioAuth.token}'});
      if (response.statusCode == 200) {
        Iterable json = jsonDecode(response.body);
        print("Busca de perfis...");
        var itens = <PerfilUsuarioModel>[];
        for (var v in json) {
          itens.add(PerfilUsuarioModel.fromJson(v));
        }
        return itens;
      } else {
        return <PerfilUsuarioModel>[];
      }
    } catch (e) {
      throw e;
    }
  }
}
