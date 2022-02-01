import 'dart:convert';

import 'package:flutter/services.dart';

/// Opções de Ambiente */
enum Environment { prod, dev, homolog, mock }

/// Classe de configuração do app */
class AppSettings {
  final String? usuario;
  final String? senha;
  final String urlBase;
  Environment? environment;
  AdMobConfig adMobConfig;

  //Constructor private
  AppSettings._(
      {this.usuario, this.senha, required this.urlBase, this.environment, required this.adMobConfig});

  static Future<AppSettings> forEnvironment(Environment env) async {
    String arq;
    switch (env) {
      case Environment.prod:
        arq = 'prod.json';
        break;
      case Environment.homolog:
        arq = 'homolog.json';
        break;
      default:
        arq = 'dev.json';
    }
    if (env == Environment.mock) {
      return AppSettings._(usuario: '', senha: '', urlBase: '', environment: env, adMobConfig: AdMobConfig());
    } else {
      final content = await rootBundle.loadString('assets/config/$arq');
      final json = jsonDecode(content);
      return AppSettings._(
          usuario: json['usuario'],
          senha: json['senha'],
          urlBase: json['urlBase'],
          environment: env,
          adMobConfig: AdMobConfig.fromJson(json['adMobConfig']));
    }
  }
}

/// Configuracoes do Admob */
class AdMobConfig {
  String? androidBannerId;
  String? androidInterstitialId;
  String? iOSBannerId;
  String? iOSInterstitialId;
  String? iOSAppId;
  String? androidAppId;

  //Why constructor is private?
  AdMobConfig(
      {this.androidBannerId,
      this.androidInterstitialId,
      this.iOSBannerId,
      this.iOSInterstitialId,
      this.iOSAppId,
      this.androidAppId});

  AdMobConfig.fromJson(Map<String, dynamic> json) {
    androidBannerId = json['androidBannerId'];
    androidInterstitialId = json['androidInterstitialId'];
    iOSBannerId = json['iOSBannerId'];
    iOSInterstitialId = json['iOSInterstitialId'];
    iOSAppId = json['iOSAppId'];
    androidAppId = json['androidAppId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['androidBannerId'] = this.androidBannerId;
    data['androidInterstitialId'] = this.androidInterstitialId;
    data['iOSBannerId'] = this.iOSBannerId;
    data['iOSInterstitialId'] = this.iOSInterstitialId;
    data['iOSAppId'] = this.iOSAppId;
    data['androidAppId'] = this.androidAppId;
    return data;
  }
}
