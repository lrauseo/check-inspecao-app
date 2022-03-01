import 'package:check_inspecao_app/app/modules/grupo/grupo_module.dart';
import 'package:check_inspecao_app/app/modules/sub_grupos/subGrupos_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/Grupos', module: GrupoModule()),
    ModuleRoute('/SubGrupos', module: SubGruposModule()),
  ];
}
