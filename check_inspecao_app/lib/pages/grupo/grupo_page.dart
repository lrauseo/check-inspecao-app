import 'package:check_inspecao_app/models/grupo_model.dart';
import 'package:check_inspecao_app/pages/grupo/grupo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GrupoPage extends StatelessWidget {
  final _controller = Modular.get<GrupoController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Grupos"),
        ),
        body: FutureBuilder<List<GrupoModel>?>(
            future: _controller.listaGrupos(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                var grupos = snapshot.data;
                return ListView.builder(
                    itemCount: grupos!.length,
                    itemBuilder: (_, idx) {
                      return ListTile(
                          title: Text(grupos![idx].descricao ?? ''),
                          onTap: () => _controller.goToItensInspecao(grupos[idx]));
                    });
              }
            }));
  }
}
