import 'package:check_inspecao_app/app/modules/perfil_usuario/perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelecaoPerfilUsuarioPage extends StatelessWidget {
  const SelecaoPerfilUsuarioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Modular.get<PerfilController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Selecionar o perfil')),
      body: Observer(builder: (_) {
        controller.buscarPerfis();
        return ListView.separated(
            itemBuilder: (context, idx) {
              var dados = controller.perfis.toList();
              return ListTile(
                title: Text(dados[idx].empresa?.razaosocial ?? dados[idx].usuario.nome!),
                subtitle: Text(dados[idx].empresa != null ? 'Funcionário(a)' : 'Autônomo(a)'),
                onTap: () => controller.goToHome(dados[idx].id),
              );
            },
            separatorBuilder: (context, idx) => const Divider(),
            itemCount: controller.perfis.length);
      }),
    );
  }
}
