import 'package:check_inspecao_app/app/config/settings/app_settings.dart';
import 'package:check_inspecao_app/constantes.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

class CustomHttp extends DioForNative {
  //final AppSettings _settings;
  final Interceptor _interceptor;
  CustomHttp(this._interceptor) {
    options.baseUrl = Constantes.baseUrl;
    options.connectTimeout = 80000;
    interceptors.add(_interceptor);
  }
}
