import 'dart:convert';
import 'dart:typed_data';

import 'package:check_inspecao_app/app/models/empresa_model.dart';
import 'package:check_inspecao_app/app/models/login_model.dart';

class UsuarioModel {
  String? id;
  String? nome;
  Uint8List? assinatura;
  String? login;
  String? senha;

  UsuarioModel({this.id, this.nome, this.login, this.senha, this.assinatura});

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    assinatura = json['assinatura'] == "" ? null : base64Decode(json['assinatura']);
    login = json['login'];
    senha = json['senha'];
    //empresa = json['Empresa'] != null ? new EmpresaModel.fromJson(json['Empresa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nome'] = nome;
    data['assinatura'] = assinatura;

    data['login'] = login;
    data['senha'] = senha;

    // if (this.empresa != null) {
    //   data['Empresa'] = this.empresa!.toJson();
    // }
    return data;
  }
}
