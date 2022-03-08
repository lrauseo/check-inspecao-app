import 'package:check_inspecao_app/app/modules/questionario/questionario_Page.dart';
import 'package:check_inspecao_app/app/modules/questionario/questionario_busca_page.dart';
import 'package:check_inspecao_app/app/modules/questionario/questionario_controller.dart';
import 'package:check_inspecao_app/app/modules/questionario/questionario_item_selecao_page.dart';
import 'package:check_inspecao_app/app/modules/sub_grupos/subGrupos_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class QuestionarioModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => QuestionarioController()),
  ];

  List<Module> get imports => [SubGruposModule()];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => QuestionarioBuscaPage()),
    ChildRoute('/Editar', child: (_, args) => const QuestionarioPage()),
    ChildRoute('/Buscar', child: (_, args) => const QuestionarioBuscaPage(retornarValor: true)),
    ChildRoute('/Selecao', child: (_, args) => const QuestionarioItemSelecaoPage()),
  ];
}
