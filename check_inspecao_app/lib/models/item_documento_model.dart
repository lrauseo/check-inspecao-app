import 'package:check_inspecao_app/models/documento_model.dart';
import 'package:check_inspecao_app/models/foto_model.dart';
import 'package:check_inspecao_app/models/item_inspecao_model.dart';

class ItemDocumentoModel {
  int id;
  ItemInspecaoModel itemInspecao;
  DocumentoModel documento;
  bool sim;
  bool nao;
  bool naoSeAplica;
  String observacao;
  bool naoObservado;
  List<FotoModel> fotos;

  ItemDocumentoModel(
      {this.id,
      this.itemInspecao,
      this.documento,
      this.sim = false,
      this.nao = false,
      this.naoSeAplica = false,
      this.observacao,
      this.naoObservado = false,
      this.fotos});

  ItemDocumentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemInspecao = json['item'] != null
        ? new ItemInspecaoModel.fromJson(json['item'])
        : null;
    documento = json['documentoPai'] != null
        ? new DocumentoModel.fromJson(json['documentoPai'])
        : null;
    sim = json['sim'];
    nao = json['nao'];
    naoSeAplica = json['naoSeAplica'];
    observacao = json['observacao'];
    naoObservado = json['naoObservado'];
    if (json['fotos'] != null) {
      fotos = <FotoModel>[];
      json['fotos'].forEach((v) {
        fotos.add(new FotoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(bool parseChildren) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (parseChildren) {
      if (this.itemInspecao != null) {
        data['item'] = this.itemInspecao.toJson();
      }
      if (this.documento != null) {
        data['documentoPai'] = this.documento.toJson(false);
      }
      if (this.fotos != null) {
        data['fotos'] = this.fotos.map((v) => v.toJson()).toList();
      }
    }
    data['sim'] = this.sim;
    data['nao'] = this.nao;
    data['naoSeAplica'] = this.naoSeAplica;
    data['observacao'] = this.observacao;
    data['naoObservado'] = this.naoObservado;
    return data;
  }
}
