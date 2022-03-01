import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:check_inspecao_app/app/modules/grupo/grupo_controller.dart';
import 'package:check_inspecao_app/app/modules/sub_grupos/subGrupos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GrupoAlteracaoPage extends StatefulWidget {
  GrupoAlteracaoPage({Key? key}) : super(key: key);

  final GrupoController controller = Modular.get();

  @override
  _GrupoAlteracaoPageState createState() => _GrupoAlteracaoPageState();
}

class _GrupoAlteracaoPageState extends State<GrupoAlteracaoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Manutenção de Grupo"),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              tooltip: 'Salvar Grupo',
              onPressed: () async {
                await widget.controller.salvarGrupo();
                Modular.to.pop();
              },
            ),
          ],
        ),
        body: Form(
            child: ListView(padding: const EdgeInsets.all(3.0), children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Observer(builder: (_) {
              if (widget.controller.grupoAtual != null) {
                widget.controller.txtCtrlDescricao.text = widget.controller.grupoAtual!.descricao!;
              } else {
                widget.controller.grupoAtual = GrupoModel();
              }
              return TextFormField(
                controller: widget.controller.txtCtrlDescricao,
                decoration: const InputDecoration(labelText: "Descrição"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Descrição é obrigatório';
                  }
                  return null;
                },
              );
            }),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: ElevatedButton(
                onPressed: () {
                  Modular.to.pushNamed('/SubGrupos/', arguments: widget.controller.grupoAtual);
                },
                child: const Text('Itens Categoria'),
              )),
        ])));
  }
}
