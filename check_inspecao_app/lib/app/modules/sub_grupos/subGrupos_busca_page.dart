import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:check_inspecao_app/app/modules/sub_grupos/subGrupos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../grupo/grupo_controller.dart';

class SubGrupoBuscaPage extends StatefulWidget {
  GrupoModel grupo;
  SubGrupoBuscaPage({Key? key, required this.grupo}) : super(key: key);
  final _controller = Modular.get<SubGruposController>();
  @override
  _SubGrupoBuscaPageState createState() => _SubGrupoBuscaPageState();
}

class _SubGrupoBuscaPageState extends State<SubGrupoBuscaPage> {
  @override
  Widget build(BuildContext context) {
    widget._controller.buscarItens(widget.grupo);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sub-Grupo'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                widget._controller.novoSubGrupo();
                Modular.to.pushNamed('/SubGrupos/alteracao');
              },
            )
          ],
        ),
        body: Observer(builder: (_) {
          return ListView.separated(
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(widget._controller.itens[index].descricao ?? ''),
                  subtitle: Text(widget._controller.itens[index].classificacao),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      widget._controller.setItemSelecionado = widget._controller.itens[index];
                      Modular.to.pushNamed('/SubGrupos/alteracao');
                    },
                  ),
                );
              },
              separatorBuilder: (_, idx) => const Divider(),
              itemCount: widget._controller.itens.length);
        }));
  }
}
