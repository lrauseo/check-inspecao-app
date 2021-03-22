import 'dart:convert';
import 'dart:typed_data';

import 'package:check_inspecao_app/models/item_documento_model.dart';

class FotoModel {
  int id;
  Uint8List arquivo;
  ItemDocumentoModel itemDocumento;

  FotoModel({this.id, this.itemDocumento, this.arquivo});

  FotoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arquivo = base64.decode(json['arquivo']);
    if (json['itemInspecao'] != null) {
      itemDocumento = ItemDocumentoModel.fromJson(json['itemInspecao']);
      // itens = <ItemDocumentoModel>[];
      // json['itens'].forEach((v) {
      //   itens.add(ItemDocumentoModel.fromJson(v));
      // });
    }
    // itemDocumento = json['itemInspecao'];
    // itemDocumento = json['itemInspecao'] != null
    //     ? new ItemInspecaoModel.fromJson(json['item'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // data['arquivo'] = base64.encode(this.arquivo);
    data['arquivo'] = this.arquivo;
    if (this.itemDocumento != null) {
      data['itemInspecao'] = this.itemDocumento.toJson(false);
    }
    return data;
  }
}
