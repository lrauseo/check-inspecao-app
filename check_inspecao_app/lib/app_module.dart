import 'package:camera/camera.dart';
import 'package:check_inspecao_app/app_Init.dart';
import 'package:check_inspecao_app/pages/documentos/documentos_controller.dart';
import 'package:check_inspecao_app/pages/documentos/documentos_page.dart';
import 'package:check_inspecao_app/pages/grupo/grupo_controller.dart';
import 'package:check_inspecao_app/pages/grupo/grupo_page.dart';
import 'package:check_inspecao_app/pages/itemInspecao/item_inspecao_controller.dart';
import 'package:check_inspecao_app/pages/itemInspecao/item_inspecao_page.dart';
import 'package:check_inspecao_app/pages/login/login_controller.dart';
import 'package:check_inspecao_app/pages/login/login_page.dart';
import 'package:check_inspecao_app/pages/perfil_usuario/perfil_usuario_page.dart';
import 'package:check_inspecao_app/pages/usuario/usuario_controller.dart';
import 'package:check_inspecao_app/pages/usuario/usuario_page.dart';
import 'package:check_inspecao_app/services/check_inspecao_service.dart';
import 'package:check_inspecao_app/widgets/camera_preview.dart';
import 'package:check_inspecao_app/widgets/draw.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  // AppModule();
  // List<CameraDescription> cameras;
  @override
  List<Bind> get binds => [
        Bind((inject) => CheckInspecaoService()),
        Bind((inject) => LoginController()),
        Bind((inject) => GrupoController()),
        Bind((inject) => DocumentosController()),
        Bind((inject) => ItemInspecaoController()),
        Bind((inject) => UsuarioController()),
        // Bind((inject) => this.cameras?.first),
        // Bind<AdMob>(
        //     (inject) => Platform.isAndroid ? AdMobAndroid() : AdMobiOS())
      ];

//  Provider<HistoricoController>(create: (_) => HistoricoController()),
//             Provider<FipeController>(create: (_) => FipeController()),
//             Provider<AdMob>(
//                 create: (_) =>
//                     Platform.isAndroid ? AdMobAndroid() : AdMobiOS()),
//           ],

  @override
  Widget get bootstrap => AppInit();

  @override
  List<ChildRoute> get routers => [
        ChildRoute('/', child: (_, args) => LoginPage()),
        ChildRoute('/Documentos', child: (_, args) => DocumentosPage()),
        ChildRoute('/Grupos', child: (_, args) => GrupoPage()),
        ChildRoute('/Perfil', child: (_, args) => PerfilUsuarioPage()),
        ChildRoute('/ItemInspecao/:grupoId',
            child: (_, args) => ItemInspecaoPage(int.parse(args.params['grupoId']))),
        ChildRoute('/TirarFoto', child: (_, args) => TakePictureScreen()),
        ChildRoute('/MostrarImagem', child: (_, args) {
          // String imagePath = (args?.data as XFile)?.path;
          return DisplayPictureScreen(imagePath: args.data);
        }),
        ChildRoute('/Assinatura', child: (_, args) => Draw()),
        ChildRoute('/CadUsuario', child: (_, args) => UsuarioPage()),

        // ChildRoute('/', child: (_, args) {
        //   var config = Modular.get<AppConfig>();
        //   return MyHomePage(title: 'SmartFipe', config: config);
        // })
      ];
}
