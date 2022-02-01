import 'package:check_inspecao_app/app/config/settings/app_settings.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

class CustomHttp extends DioForNative {
  final AppSettings _settings;
  final Interceptor _interceptor;

  CustomHttp(this._settings, this._interceptor) {
    options.baseUrl = _settings.urlBase;
    options.connectTimeout = 80000;
    interceptors.add(_interceptor);
  }
}
