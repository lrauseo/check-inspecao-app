class UsuarioModel {
  int id;
  String nome;
  Null login;

  UsuarioModel({this.id, this.nome, this.login});

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    login = json['login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['login'] = this.login;
    return data;
  }
}
