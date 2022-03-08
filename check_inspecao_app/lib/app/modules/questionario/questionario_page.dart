import 'package:check_inspecao_app/app/models/item_inspecao_model.dart';
import 'package:check_inspecao_app/app/models/item_inspecao_questionario_formulario_model.dart';
import 'package:check_inspecao_app/app/modules/questionario/questionario_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mobx/mobx.dart';

class QuestionarioPage extends StatefulWidget {
  const QuestionarioPage({Key? key}) : super(key: key);
  @override
  QuestionarioPageState createState() => QuestionarioPageState();
}

class QuestionarioPageState extends State<QuestionarioPage> {
  final QuestionarioController store = Modular.get();

  var disposers = <ReactionDisposer>[];

  @override
  void initState() {
    disposers = [
      reaction((_) => store.exceptionApp, (_) {
        if (store.exceptionApp != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(store.exceptionApp!.message!),
            backgroundColor: Colors.red,
          ));
        }
      })
    ];
    super.initState();
  }

  @override
  void dispose() {
    for (var item in disposers) {
      item();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manutenção de Formulário'),
          actions: [IconButton(onPressed: () => store.salvarQuestionario(), icon: const Icon(Icons.save))],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                controller: store.txtCtrlDescricao,
                decoration: const InputDecoration(labelText: "Descrição"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Descrição é obrigatório';
                  }
                  return null;
                },
              ),
              Observer(builder: (_) {
                return CheckboxListTile(
                  title: const Text('Inativo'),
                  value: store.questionarioSelecionado?.isInativo,
                  onChanged: (bool? value) {
                    store.setisInativo = value ?? false;
                  },
                  controlAffinity: ListTileControlAffinity.platform,
                );
              }),
              ElevatedButton(
                onPressed: () => store.addNovoItemQuestionario(),
                child: const Text('Adicionar/Excluir Questionário'),
              ),
              Expanded(
                child: Observer(builder: (_) {
                  return GroupedListView<ItemInspecaoQuestionarioFormulario?, String>(
                    separator: const Divider(),
                    itemBuilder: (_, item) {
                      return ListTile(title: Text(item?.itemInspecao?.descricao ?? ''));
                    },
                    elements: store.questionarioSelecionado?.itensQuestionario ??
                        <ItemInspecaoQuestionarioFormulario>[],
                    groupBy: (element) => element?.itemInspecao?.grupo?.descricao ?? '',
                    groupComparator: (x, y) => x.compareTo(y),
                    groupSeparatorBuilder: (String groupByValue) =>
                        Container(color: const Color.fromARGB(255, 197, 194, 194), child: Text(groupByValue)),
                  );
                }),
              ),
            ],
          )),
        ));
  }
}
