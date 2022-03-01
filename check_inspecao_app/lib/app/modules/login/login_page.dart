import 'dart:io';

import 'package:check_inspecao_app/app/modules/login/login_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobx/mobx.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginControler = Modular.get<LoginController>();
  List<ReactionDisposer> disposers = [];
  void initState() {
    disposers = [
      reaction((_) => _loginControler.exceptionApp, (_) {
        if (_loginControler.exceptionApp != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(_loginControler.exceptionApp!.message!),
            backgroundColor: Colors.red,
          ));
        }
      })
    ];
    super.initState();
  }

  @override
  void dispose() {
    for (var element in disposers) {
      element();
    }
    Modular.dispose<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("Login"),
            TextField(
              decoration: const InputDecoration(labelText: "Usuario"),
              controller: _loginControler.usuarioCtrl,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: "Senha"),
              controller: _loginControler.senhaTxtCtrl,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Observer(builder: (_) {
                _loginControler.loading ? context.loaderOverlay.show() : context.loaderOverlay.hide();
                return ElevatedButton(
                  onPressed: () async {
                    if (await _loginControler.validarLogin()) {
                      Modular.to.pushReplacementNamed("/SelecaoPerfil");
                    }
                    // } else {
                    //   ScaffoldMessenger.of(context)
                    //       .showSnackBar(SnackBar(content: Text("Usuário/Senha Inválido")));
                    // }
                  },
                  child: const Text('Login'),
                );
              }),
            ),
            InkWell(
              child: const Text(
                'Criar Novo Usuário',
                style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
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
    );
  }
}
