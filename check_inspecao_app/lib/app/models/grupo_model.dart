class GrupoModel {
  int? id;
  String? descricao;

  GrupoModel({this.id, this.descricao});

  GrupoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    data['descricao'] = this.descricao;
    return data;
  }
}
