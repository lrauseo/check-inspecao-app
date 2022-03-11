import 'package:check_inspecao_app/app/modules/grupo/grupo_alteracao_page.dart';
import 'package:check_inspecao_app/app/modules/grupo/grupo_controller.dart';
import 'package:check_inspecao_app/app/modules/grupo/grupo_busca_page.dart';
import 'package:check_inspecao_app/app/modules/grupo/grupo_module.dart';
import 'package:check_inspecao_app/app/modules/itemInspecao/item_inspecao_controller.dart';
import 'package:check_inspecao_app/app/modules/itemInspecao/item_inspecao_page.dart';
import 'package:check_inspecao_app/app/modules/login/login_controller.dart';
import 'package:check_inspecao_app/app/modules/login/login_page.dart';
import 'package:check_inspecao_app/app/modules/perfil_usuario/perfil_controller.dart';
import 'package:check_inspecao_app/app/modules/perfil_usuario/perfil_usuario_page.dart';
import 'package:check_inspecao_app/app/modules/perfil_usuario/selecao_perfil_usuario_page.dart';
import 'package:check_inspecao_app/app/modules/usuario/usuario_controller.dart';
import 'package:check_inspecao_app/app/modules/usuario/usuario_page.dart';
import 'package:check_inspecao_app/app/services/check_inspecao_service.dart';
import 'package:check_inspecao_app/app/widgets/camera_preview.dart';
import 'package:check_inspecao_app/app/widgets/draw.dart';
import 'package:check_inspecao_app/app/widgets/signature_draw.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_controller.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController()),
    Bind((inject) => LoginController()),
    //Bind((inject) => DocumentosController()),
    Bind((inject) => ItemInspecaoController()),
    Bind((inject) => UsuarioController()),
    Bind((inject) => PerfilController()),
    Bind.singleton((inject) async => await SharedPreferences.getInstance())
  ];
  List<Module> get imports => [GrupoModule()];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => LoginPage()),
    //ChildRoute('/', child: (_, args) => LoginPage()),
    ChildRoute('/Documentos', child: (_, args) => HomePage()),

    ChildRoute('/Perfil', child: (_, args) => PerfilUsuarioPage()),
    ChildRoute('/ItemInspecao/:grupoId',
        child: (_, args) => ItemInspecaoPage(formularioId: int.parse(args.params['grupoId']))),
    ChildRoute('/ItemInspecao', child: (_, args) => ItemInspecaoPage(formularioId: null)),
    ChildRoute('/TirarFoto', child: (_, args) => TakePictureScreen()),
    ChildRoute('/MostrarImagem', child: (_, args) {
      // String imagePath = (args?.data as XFile)?.path;
      return DisplayPictureScreen(imagePath: args.data);
    }),
    ChildRoute('/Assinatura', child: (_, args) => const SignatureDraw()),
    ChildRoute('/CadUsuario', child: (_, args) => UsuarioPage()),
    ChildRoute('/SelecaoPerfil', child: (_, args) => const SelecaoPerfilUsuarioPage()),
  ];
}
