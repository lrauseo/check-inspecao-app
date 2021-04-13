import 'package:check_inspecao_app/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppInit extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriApp',
      // theme: Styles.themeData(context),
      // darkTheme: Styles.darkThemeData(context),
      initialRoute: '/',
      theme: Style.themeData(context),
      // darkTheme: Style.themeDataDark(context),
      onGenerateRoute: Modular.generateRoute,
      navigatorKey: Modular.navigatorKey,
    );
  }
}
