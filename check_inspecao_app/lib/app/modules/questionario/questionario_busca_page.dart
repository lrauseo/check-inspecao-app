import 'package:check_inspecao_app/app/modules/questionario/questionario_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loader_overlay/loader_overlay.dart';

class QuestionarioBuscaPage extends StatefulWidget {
  final bool? retornarValor;
  const QuestionarioBuscaPage({Key? key, this.retornarValor = false}) : super(key: key);

  @override
  _QuestionarioBuscaPageState createState() => _QuestionarioBuscaPageState();
}

class _QuestionarioBuscaPageState extends State<QuestionarioBuscaPage> {
  late QuestionarioController _controller;
  @override
  void initState() {
    _controller = Modular.get();
    super.initState();
  }

  @override
  void dispose() {
    Modular.dispose<QuestionarioController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.buscarQuestionarios();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulários'),
        actions: widget.retornarValor!
            ? null
            : [IconButton(onPressed: () => _controller.novoQuestionario(), icon: const Icon(Icons.add))],
      ),
      body: Observer(builder: (_) {
        _controller.loading ? context.loaderOverlay.show() : context.loaderOverlay.hide();
        return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_controller.questionarios[index].descricao ?? ''),
                subtitle: Text(_controller.questionarios[index].isInativo ? 'Inativo' : ''),
                trailing: const Icon(Icons.file_open),
                onTap: () {
                  if (widget.retornarValor!) {
                    Modular.to.pop<int?>(_controller.questionarios[index].id);
                  } else {
                    _controller.questionarioSelecionado = _controller.questionarios[index];
                    _controller.editarQuestionario();
                  }
                },
              );
            },
            //separatorBuilder: (_, idx) => const Divider(),
            itemCount: _controller.questionarios.length);
      }),
    );
  }
}
