import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:check_inspecao_app/app/modules/grupo/grupo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GrupoPage extends StatelessWidget {
  final _controller = Modular.get<GrupoController>();

  GrupoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Grupos"),
        ),
        body: FutureBuilder<List<GrupoModel>?>(
            future: _controller.listaGrupos(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var grupos = snapshot.data;
                return ListView.builder(
                    itemCount: grupos!.length,
                    itemBuilder: (_, idx) {
                      return ListTile(
                          title: Text(grupos[idx].descricao ?? ''),
                          onTap: () => _controller.goToItensInspecao(grupos[idx]));
                    });
              }
            }));
  }
}
