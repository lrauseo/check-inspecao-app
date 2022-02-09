import 'package:check_inspecao_app/app/models/empresa_model.dart';
import 'package:check_inspecao_app/app/models/usuario_model.dart';

class PerfilUsuarioModel {
  late int id;
  late UsuarioModel usuario;
  EmpresaModel? empresa;
  bool? isInativo;

  PerfilUsuarioModel({required this.id, required this.usuario, this.empresa, this.isInativo});

  PerfilUsuarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuario = UsuarioModel.fromJson(json['usuario']);
    empresa = json['empresa'];
    isInativo = json['isInativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (usuario != null) {
      data['usuario'] = usuario.toJson();
    }
    data['empresa'] = empresa;
    data['isInativo'] = isInativo;
    return data;
  }
}
