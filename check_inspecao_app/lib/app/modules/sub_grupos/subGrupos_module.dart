import 'package:check_inspecao_app/app/models/grupo_model.dart';
import 'package:check_inspecao_app/app/modules/sub_grupos/subGrupos_Page.dart';
import 'package:check_inspecao_app/app/modules/sub_grupos/subGrupos_busca_page.dart';
import 'package:check_inspecao_app/app/modules/sub_grupos/subGrupos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SubGruposModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SubGruposController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/alteracao', child: (_, args) => SubGruposPage()),
    ChildRoute('/', child: (_, args) => SubGrupoBuscaPage(grupo: args.data as GrupoModel)),
  ];
}
