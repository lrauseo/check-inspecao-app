import 'dart:typed_data';

import 'package:check_inspecao_app/models/empresa_model.dart';
import 'package:check_inspecao_app/models/login_model.dart';
import 'package:check_inspecao_app/models/usuario_model.dart';
import 'package:check_inspecao_app/pages/usuario/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsuarioPage extends StatefulWidget {
  final _controller = Modular.get<UsuarioController>();
  final _ctrlCnpj = TextEditingController();
  final _ctrlNome = TextEditingController();
  final _ctrlLogin = TextEditingController();
  final _ctrlSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isBusy = false;
  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Usuário'),
        actions: [
          IconButton(
            icon: widget._isBusy
                ? CircularProgressIndicator(
                    backgroundColor: Colors.amber,
                    strokeWidth: 1.0,
                  )
                : Icon(Icons.save),
            onPressed: widget._isBusy
                ? null
                : () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (widget._formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      setState(() {
                        widget._isBusy = true;
                      });
                      UsuarioModel usuarioModel;
                      if (widget._controller.usuario != null) {
                        usuarioModel = widget._controller.usuario!;
                      } else {
                        usuarioModel = UsuarioModel();
                      }
                      usuarioModel.empresa = EmpresaModel(cnpj: widget._ctrlCnpj.text);
                      usuarioModel.login =
                          LoginModel(usuariologin: widget._ctrlLogin.text, senha: widget._ctrlSenha.text);
                      usuarioModel.nome = widget._ctrlNome.text;
                      widget._controller.setUsuario(usuarioModel);
                      try {
                        if (await widget._controller.salvarUsuario()) {
                          setState(() {
                            widget._isBusy = false;
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Salvo Com Sucesso!')));
                          Modular.to.pop();
                        }
                      } on Exception catch (e) {
                        setState(() {
                          widget._isBusy = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: widget._formKey,
              child: ListView(
                padding: EdgeInsets.all(3.0),
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Center(
                        child: CircleAvatar(
                      maxRadius: 60.0,
                    )),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "CNPJ Empresa"),
                    maxLength: 14,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informa o CNPJ da Empresa';
                      }
                      return null;
                    },
                    controller: widget._ctrlCnpj,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Nome"),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informa o Nome';
                        }
                        return null;
                      },
                      controller: widget._ctrlNome,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "E-Mail"),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o E-Mail';
                        }
                        return null;
                      },
                    ),
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(labelText: "CPF"),
                  //   // The validator receives the text that the user has entered.
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Informe o CPF';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  Divider(),
                  Text('Dados de Login'),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Login"),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o Login';
                        }
                        return null;
                      },
                      controller: widget._ctrlLogin,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Senha"),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o Senha';
                        }
                        return null;
                      },
                      controller: widget._ctrlSenha,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Uint8List imagem = await Modular.to.pushNamed('/Assinatura') as Uint8List;
                      var usuarioModel = widget._controller.usuario ?? UsuarioModel();
                      usuarioModel.assinatura = imagem;
                      widget._controller.setUsuario(usuarioModel);
                    },
                    child: Text('Cadastrar Assinatura'),
                  ),
                  Observer(builder: (_) {
                    return Center(
                        child: widget._controller.usuario?.assinatura == null
                            ? Container()
                            : Image.memory(widget._controller.usuario?.assinatura ?? Uint8List(0)));
                  })
                ],
              ))),
    );
  }
}
