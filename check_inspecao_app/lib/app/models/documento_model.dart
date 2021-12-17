import 'package:check_inspecao_app/app/models/cliente_model.dart';
import 'package:check_inspecao_app/app/models/item_documento_model.dart';
import 'package:check_inspecao_app/app/models/usuario_model.dart';

class DocumentoModel {
  int? id;
  List<ItemDocumentoModel>? itens;
  UsuarioModel? usuarioInspecao;
  ClienteModel? cliente;
  DateTime? dataDocumento;

  DocumentoModel({this.id, this.itens, this.usuarioInspecao, this.cliente, this.dataDocumento});

  DocumentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataDocumento = DateTime.parse(json['dataDocumento']);
    if (json['itens'] != null) {
      itens = <ItemDocumentoModel>[];
      json['itens'].forEach((v) {
        itens!.add(ItemDocumentoModel.fromJson(v));
      });
    }
    usuarioInspecao =
        json['usuarioInspecao'] != null ? new UsuarioModel.fromJson(json['usuarioInspecao']) : null;
    cliente = json['cliente'] != null ? new ClienteModel.fromJson(json['cliente']) : null;
  }

  Map<String, dynamic> toJson(bool parseChildren) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dataDocumento'] = this.dataDocumento.toString();

    if (parseChildren) {
      if (this.itens != null) {
        data['itens'] = this.itens!.map((v) => v.toJson(true)).toList();
      }
      if (this.usuarioInspecao != null) {
        data['usuarioInspecao'] = this.usuarioInspecao!.toJson();
      }
      if (this.cliente != null) {
        data['cliente'] = this.cliente!.toJson();
      }
    }
    return data;
  }
}
