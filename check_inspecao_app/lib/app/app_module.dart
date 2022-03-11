import 'package:check_inspecao_app/app/config/http/custom_http.dart';
import 'package:check_inspecao_app/app/config/http/interceptor/http_interceptor.dart';
import 'package:check_inspecao_app/app/config/settings/app_settings.dart';
import 'package:check_inspecao_app/app/config/storage/prefs_storage.dart';
import 'package:check_inspecao_app/app/models/usuario_model.dart';
import 'package:check_inspecao_app/app/modules/grupo/grupo_module.dart';
import 'package:check_inspecao_app/app/modules/questionario/questionario_module.dart';
import 'package:check_inspecao_app/app/modules/sub_grupos/subGrupos_module.dart';
import 'package:check_inspecao_app/app/services/check_inspecao_service.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  final SharedPreferences _preferences;
  AppModule(this._preferences);
  @override
  List<Bind> get binds => [
        Bind.factory((i) => CheckInspecaoService(i.get<DioForNative>())),
        Bind.singleton<SharedPreferences>((i) => _preferences),
        Bind.singleton<PrefsStorage>((i) => PrefsStorage(i.get<SharedPreferences>())),
        Bind.singleton<HttpInterceptor>((i) => HttpInterceptor(i.get<PrefsStorage>())),
        Bind.singleton<CustomHttp>((i) => CustomHttp(i.get<HttpInterceptor>())),
      ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/Grupos', module: GrupoModule()),
    ModuleRoute('/SubGrupos', module: SubGruposModule()),
    ModuleRoute('/Questionarios/', module: QuestionarioModule()),
  ];
}
