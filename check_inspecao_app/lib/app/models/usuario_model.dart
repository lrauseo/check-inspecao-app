import 'dart:convert';
import 'dart:typed_data';

import 'package:check_inspecao_app/app/models/empresa_model.dart';
import 'package:check_inspecao_app/app/models/login_model.dart';

class UsuarioModel {
  int? id;
  String? nome;
  Uint8List? assinatura;
  LoginModel? login;
  EmpresaModel? empresa;

  UsuarioModel({this.id, this.nome, this.login, this.empresa, this.assinatura});

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    nome = json['nome'];
    assinatura = json['assinatura'] == "" ? null : base64Decode(json['assinatura']);
    login = json['Login'] != null ? new LoginModel.fromJson(json['Login']) : null;
    empresa = json['Empresa'] != null ? new EmpresaModel.fromJson(json['Empresa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    data['nome'] = this.nome;
    data['assinatura'] = this.assinatura;
    if (this.login != null) {
      data['Login'] = this.login!.toJson();
    }
    if (this.empresa != null) {
      data['Empresa'] = this.empresa!.toJson();
    }
    return data;
  }
}
