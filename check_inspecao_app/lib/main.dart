import 'dart:io';

import 'package:camera/camera.dart';
import 'package:check_inspecao_app/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // List<CameraDescription> cameras;
  // if (Platform.isAndroid || Platform.isIOS) cameras = await availableCameras();
  SharedPreferences.setMockInitialValues({});
  // final firstCamera = cameras.first;
  runApp(ModularApp(module: AppModule()));
}
