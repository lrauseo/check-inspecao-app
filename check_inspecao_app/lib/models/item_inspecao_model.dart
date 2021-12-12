import 'package:check_inspecao_app/models/grupo_model.dart';

class ItemInspecaoModel {
  int? id;
  GrupoModel? grupo;
  String? _classificacao;

  String get classificacao {
    if (_classificacao?.toLowerCase() == "r")
      return "Recomendável";
    else if (_classificacao?.toLowerCase() == "n")
      return "Necessário";
    else if (_classificacao?.toLowerCase() == "i")
      return "Imprescindível";
    else
      return _classificacao ?? '';
  }

  set classificacao(String classificacao) {
    _classificacao = classificacao;
  }

  String? descricao;
  bool? sim;
  bool? nao;
  bool? naoSeAplica;
  bool? naoObservado;

  ItemInspecaoModel(
      {this.id,
      this.grupo,
      classificacao,
      this.descricao,
      this.sim,
      this.nao,
      this.naoSeAplica,
      this.naoObservado}) {
    _classificacao = classificacao;
  }

  ItemInspecaoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grupo = json['grupo'] != null ? new GrupoModel.fromJson(json['grupo']) : null;
    _classificacao = json['classificacao'];
    descricao = json['descricao'];
    sim = json['sim'];
    nao = json['nao'];
    naoSeAplica = json['naoSeAplica'];
    naoObservado = json['naoObservado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.grupo != null) {
      data['grupo'] = this.grupo!.toJson();
    }
    data['classificacao'] = this._classificacao;
    data['descricao'] = this.descricao;
    data['sim'] = this.sim;
    data['nao'] = this.nao;
    data['naoSeAplica'] = this.naoSeAplica;
    data['naoObservado'] = this.naoObservado;
    return data;
  }
}
