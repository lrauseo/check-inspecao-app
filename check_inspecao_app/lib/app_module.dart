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
import 'package:check_inspecao_app/services/check_inspecao_service.dart';
import 'package:check_inspecao_app/widgets/camera_preview.dart';
import 'package:check_inspecao_app/widgets/draw.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule {
  AppModule(this.cameras);
  List<CameraDescription> cameras;
  @override
  List<Bind> get binds => [
        Bind((inject) => CheckInspecaoService()),
        Bind((inject) => LoginController()),
        Bind((inject) => GrupoController()),
        Bind((inject) => DocumentosController()),
        Bind((inject) => ItemInspecaoController()),
        Bind((inject) => this.cameras?.first),
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
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => LoginPage()),
        ModularRouter('/Documentos', child: (_, args) => DocumentosPage()),
        ModularRouter('/Grupos', child: (_, args) => GrupoPage()),
        ModularRouter('/Perfil', child: (_, args) => PerfilUsuarioPage()),
        ModularRouter('/ItemInspecao/:grupoId',
            child: (_, args) =>
                ItemInspecaoPage(int.parse(args.params['grupoId']))),
        ModularRouter('/TirarFoto', child: (_, args) => TakePictureScreen()),
        ModularRouter('/MostrarImagem', child: (_, args) {
          // String imagePath = (args?.data as XFile)?.path;
          return DisplayPictureScreen(imagePath: args?.data);
        }),
        ModularRouter('/Assinatura', child: (_, args) => Draw()),
        // ModularRouter('/', child: (_, args) {
        //   var config = Modular.get<AppConfig>();
        //   return MyHomePage(title: 'SmartFipe', config: config);
        // })
      ];
}
