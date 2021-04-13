import 'dart:io';

import 'package:check_inspecao_app/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usuarioCtrl = TextEditingController();

  final _senhaTxtCtrl = TextEditingController();

  final _loginControler = Modular.get<LoginController>();

  bool _loading = false;

  @override
  void dispose() {
    _usuarioCtrl.dispose();

    _senhaTxtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Container(
        // padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     // colorFilter: ColorFilter.mode(
        //     //     Colors.white.withOpacity(0.7), BlendMode.dstATop),
        //     image: AssetImage('images/fundo_app.png'),
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("Login"),
              TextField(
                decoration: InputDecoration(labelText: "Usuario"),
                controller: _usuarioCtrl,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: "Senha"),
                controller: _senhaTxtCtrl,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () async {
                          setState(() {
                            _loading = true;
                          });

                          try {
                            if (await _loginControler.validarLogin(
                                _usuarioCtrl.text, _senhaTxtCtrl.text)) {
                              Modular.to.pushReplacementNamed("/Documentos");
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Usuário/Senha Inválido")));
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          } finally {
                            setState(() {
                              _loading = false;
                            });
                          }
                        },
                  child: _loading == false
                      ? Text("Login")
                      : CircularProgressIndicator(
                          backgroundColor: Colors.amber,
                          strokeWidth: 3.0,
                        ),
                ),
              ),
              InkWell(
                child: Text(
                  'Criar Novo Usuário',
                  style: TextStyle(
                      decoration: TextDecoration.underline, color: Colors.blue),
                ),
                onTap: () {
                  Modular.to.pushNamed(
                    '/CadUsuario',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
