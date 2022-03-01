import 'package:check_inspecao_app/app/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SecondaryButtonStandard extends StatelessWidget {
  late final void Function()? onPressed;
  late final Widget child;
  late final VoidCallback? onLongPress;
  late final ButtonStyle? style;
  late final FocusNode? focusNode;
  late final bool autofocus;
  late final Clip clipBehavior;

  SecondaryButtonStandard({
    Key? key,
    required this.onPressed,
    required this.child,
    this.onLongPress,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final ButtonStyle? buttonStyle;
    if (style != null) {
      buttonStyle = style!.copyWith(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))));
    } else {
      buttonStyle = ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(CustomColors.pink),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))));
    }
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onLongPress: onLongPress,
      style: buttonStyle,
      key: key,
    );
  }
}
