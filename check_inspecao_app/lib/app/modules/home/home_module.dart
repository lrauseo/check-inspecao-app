import 'package:check_inspecao_app/app/modules/grupo/grupo_controller.dart';
import 'package:check_inspecao_app/app/modules/grupo/grupo_page.dart';
import 'package:check_inspecao_app/app/modules/itemInspecao/item_inspecao_controller.dart';
import 'package:check_inspecao_app/app/modules/itemInspecao/item_inspecao_page.dart';
import 'package:check_inspecao_app/app/modules/login/login_controller.dart';
import 'package:check_inspecao_app/app/modules/login/login_page.dart';
import 'package:check_inspecao_app/app/modules/usuario/usuario_controller.dart';
import 'package:check_inspecao_app/app/modules/usuario/usuario_page.dart';
import 'package:check_inspecao_app/app/services/check_inspecao_service.dart';
import 'package:check_inspecao_app/app/widgets/camera_preview.dart';
import 'package:check_inspecao_app/app/widgets/draw.dart';
import 'package:check_inspecao_app/app/widgets/signature_draw.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController()),
    Bind((inject) => CheckInspecaoService()),
    Bind((inject) => LoginController()),
    Bind((inject) => GrupoController()),
    //Bind((inject) => DocumentosController()),
    Bind((inject) => ItemInspecaoController()),
    Bind((inject) => UsuarioController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => LoginPage()),
    //ChildRoute('/', child: (_, args) => LoginPage()),
    ChildRoute('/Documentos', child: (_, args) => HomePage()),
    ChildRoute('/Grupos', child: (_, args) => GrupoPage()),
    //ChildRoute('/Perfil', child: (_, args) => PerfilUsuarioPage()),
    ChildRoute('/ItemInspecao/:grupoId',
        child: (_, args) => ItemInspecaoPage(int.parse(args.params['grupoId']))),
    ChildRoute('/TirarFoto', child: (_, args) => TakePictureScreen()),
    ChildRoute('/MostrarImagem', child: (_, args) {
      // String imagePath = (args?.data as XFile)?.path;
      return DisplayPictureScreen(imagePath: args.data);
    }),
    ChildRoute('/Assinatura', child: (_, args) => const SignatureDraw()),
    ChildRoute('/CadUsuario', child: (_, args) => UsuarioPage()),
  ];
}