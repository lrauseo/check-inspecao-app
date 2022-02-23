class EmpresaModel {
  int? id;
  String? razaosocial;
  String? cnpj;
  String? endereco;
  int? numero;
  Null complemento;
  String? cep;
  String? cidade;
  String? uf;

  EmpresaModel(
      {this.id,
      this.razaosocial,
      this.cnpj,
      this.endereco,
      this.numero,
      this.complemento,
      this.cep,
      this.cidade,
      this.uf});

  EmpresaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    razaosocial = json['razaosocial'];
    cnpj = json['cnpj'];
    endereco = json['endereco'];
    numero = json['numero'];
    complemento = json['complemento'];
    cep = json['cep'];
    cidade = json['cidade'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    data['razaosocial'] = this.razaosocial;
    data['cnpj'] = this.cnpj;
    data['endereco'] = this.endereco;
    data['numero'] = this.numero ?? 0;
    data['complemento'] = this.complemento;
    data['cep'] = this.cep;
    data['cidade'] = this.cidade;
    data['uf'] = this.uf;
    return data;
  }
}
