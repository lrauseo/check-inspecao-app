import 'package:check_inspecao_app/app/models/usuario_model.dart';

class UsuarioAuthModel {
  String? token;
  String? validadeToken;
  UsuarioModel? usuario;

  UsuarioAuthModel({this.token, this.validadeToken, this.usuario});

  UsuarioAuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    validadeToken = json['validadeToken'];
    usuario = json['usuario'] != null ? UsuarioModel.fromJson(json['usuario']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['validadeToken'] = this.validadeToken;
    if (usuario != null) {
      data['usuario'] = this.usuario!.toJson();
    }
    return data;
  }
}
