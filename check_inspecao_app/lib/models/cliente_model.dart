class ClienteModel {
  int id;
  String nome;
  String cpf;
  String dataCadastro;
  // List<DocumentoModel> documentos;

  ClienteModel({this.id, this.nome, this.cpf, this.dataCadastro});

  ClienteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cpf = json['cpf'];
    dataCadastro = json['dataCadastro'];
    // login = json['login'];
    // empresa = json['empresa'];
    // if (json['documentos'] != null) {
    //   documentos = <DocumentoModel>[];
    //   json['documentos'].forEach((v) {
    //     documentos.add(new DocumentoModel.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['dataCadastro'] = this.dataCadastro;
    // data['login'] = this.login;
    // data['empresa'] = this.empresa;
    // if (this.documentos != null) {
    //   data['documentos'] = this.documentos.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
