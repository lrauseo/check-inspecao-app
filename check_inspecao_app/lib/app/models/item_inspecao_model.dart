import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:mobx/mobx.dart';

class ItemInspecaoModel extends Equatable {
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
    data['id'] = id ?? 0;
    if (this.grupo != null) {
      data['grupo'] = this.grupo!.toJson();
    }
    data['classificacao'] = _classificacao?.substring(0, 1).toUpperCase();
    data['descricao'] = this.descricao;
    data['sim'] = this.sim;
    data['nao'] = this.nao;
    data['naoSeAplica'] = this.naoSeAplica;
    data['naoObservado'] = this.naoObservado;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, grupo, classificacao, descricao, sim, nao, naoSeAplica, naoObservado];
}
