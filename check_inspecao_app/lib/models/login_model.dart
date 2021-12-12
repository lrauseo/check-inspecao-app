class LoginModel {
  int? id;
  String? usuariologin;
  String? senha;

  LoginModel({this.id, this.usuariologin, this.senha});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    usuariologin = json['usuariologin'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    data['usuariologin'] = this.usuariologin;
    data['senha'] = this.senha;
    return data;
  }
}
