import 'dart:ui';

import 'package:flutter/widgets.dart';

class LogoApp extends StatelessWidget {
  late final Key? key;
  late final double? size;
  late final Color textColor; //
  late final FlutterLogoStyle style; //
  late final Duration duration; //
  late final Curve curve; //

  LogoApp(
      {this.key,
      this.size,
      this.textColor = const Color(0xFF757575),
      this.style = FlutterLogoStyle.markOnly,
      this.duration = const Duration(milliseconds: 750),
      this.curve = Curves.fastOutSlowIn});

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double? iconSize = size ?? iconTheme.size;
    return AnimatedContainer(
      width: iconSize,
      height: iconSize,
      duration: duration,
      curve: curve,
      child: Image(
        image: AssetImage('assets/images/logo.png'),
      ),
      // decoration: FlutterLogoDecoration(
      //   style: style,
      //   textColor: textColor,
      // ),
    );
  }
}
