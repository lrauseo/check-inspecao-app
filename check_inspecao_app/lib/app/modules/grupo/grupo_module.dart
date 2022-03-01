import 'package:flutter_modular/flutter_modular.dart';

import 'grupo_alteracao_page.dart';
import 'grupo_busca_page.dart';
import 'grupo_controller.dart';

class GrupoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((inject) => GrupoController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/GrupoAlteracao', child: (_, args) => GrupoAlteracaoPage()),
    ChildRoute('/:manutencao',
        child: (_, args) => GrupoBuscaPage(
              manutencao: (args.params['manutencao'].toString().toLowerCase() == "true"),
            )),
  ];
}
