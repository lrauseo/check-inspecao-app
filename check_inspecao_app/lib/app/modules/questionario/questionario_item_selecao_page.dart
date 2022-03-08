import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:check_inspecao_app/app/modules/questionario/questionario_controller.dart';
import 'package:check_inspecao_app/app/modules/sub_grupos/subGrupos_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loader_overlay/loader_overlay.dart';

class QuestionarioItemSelecaoPage extends StatefulWidget {
  const QuestionarioItemSelecaoPage({Key? key}) : super(key: key);

  @override
  State<QuestionarioItemSelecaoPage> createState() => _QuestionarioItemSelecaoPageState();
}

class _QuestionarioItemSelecaoPageState extends State<QuestionarioItemSelecaoPage> {
  QuestionarioController store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionários'),
        actions: [
          Observer(builder: (_) {
            return IconButton(
              icon: Icon(store.todosSelecionados ? Icons.check_box_outline_blank : Icons.check_box),
              onPressed: () => store.selecionarTodos(),
            );
          }),
          IconButton(onPressed: () => Modular.to.pop(), icon: const Icon(Icons.save))
        ],
      ),
      body: Observer(builder: (_) {
        store.loading ? context.loaderOverlay.show() : context.loaderOverlay.hide();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Observer(builder: (_) {
                  return CheckboxListTile(
                    title: Text(store.itensSelecaoTela[index]['item'].descricao),
                    value: store.itensSelecaoTela[index]['checked'],
                    onChanged: (bool? value) {
                      if (!value!) {
                        store.itemInspecaoRemovido = store.itensSelecaoTela[index]['item'];
                      } else {
                        store.itemInspecaoSelecionado = store.itensSelecaoTela[index]['item'];
                      }
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                });
              },
              //separatorBuilder: (_, idx) => const Divider(),
              itemCount: store.itensSelecaoTela.length),
        );
      }),
    );
  }
}
