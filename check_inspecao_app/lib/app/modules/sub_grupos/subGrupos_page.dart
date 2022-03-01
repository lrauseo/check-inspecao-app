import 'package:check_inspecao_app/app/modules/sub_grupos/subGrupos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter/material.dart';

class SubGruposPage extends StatefulWidget {
  final String title;
  const SubGruposPage({Key? key, this.title = 'SubGruposPage'}) : super(key: key);
  @override
  SubGruposPageState createState() => SubGruposPageState();
}

class SubGruposPageState extends State<SubGruposPage> {
  final SubGruposController _controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                _controller.salvarSubGrupo();
                Modular.to.pop();
              },
            )
          ],
        ),
        body: Form(
            child: Column(
          children: [
            TextFormField(
              controller: _controller.txtCtrlClassificacao,
              decoration: const InputDecoration(labelText: "Classificação"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Classificação é obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              maxLines: 5,
              controller: _controller.txtCtrlDescricao,
              decoration: const InputDecoration(labelText: "Descrição"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Descrição é obrigatório';
                }
                return null;
              },
            ),
          ],
        )));
  }
}
