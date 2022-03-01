import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:check_inspecao_app/app/modules/grupo/grupo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GrupoBuscaPage extends StatelessWidget {
  final _controller = Modular.get<GrupoController>();
  late bool manutencao;
  GrupoBuscaPage({Key? key, required this.manutencao}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _controller.listaGrupos();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Grupos"),
          actions: [
            manutencao
                ? IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _controller.novoGrupo();
                      Modular.to.pushNamed('/Grupos/GrupoAlteracao');
                    },
                  )
                : Container(),
          ],
        ),
        body: Observer(
            builder: (context) => ListView.builder(
                itemCount: _controller.grupos.length,
                itemBuilder: (_, idx) {
                  return ListTile(
                      title: Text(_controller.grupos[idx].descricao ?? ''),
                      trailing: manutencao
                          ? IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () {
                                _controller.grupoAtual = _controller.grupos[idx];
                                Modular.to.pushNamed('/Grupos/GrupoAlteracao');
                              },
                            )
                          : null,
                      onTap: () => !manutencao ? Modular.to.pop<int?>(_controller.grupos[idx].id) : null);
                })));
  }
}
