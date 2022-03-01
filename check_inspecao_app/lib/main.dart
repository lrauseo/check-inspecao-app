import 'package:check_inspecao_app/app/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.landscapeRight])
      .then((value) => runApp(GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: Center(
            child: SpinKitDoubleBounce(
              color: CustomColors.pink,
              size: 50.0,
            ),
          ),
          child: ModularApp(module: AppModule(), child: AppWidget()))));
}
