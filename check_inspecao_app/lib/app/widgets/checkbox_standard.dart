import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckboxStandard extends StatelessWidget {
  final Widget? secondary;
  final String? title;
  final EdgeInsets? padding;
  final bool? value;
  final Function(bool?)? onChanged;
  const CheckboxStandard({
    Key? key,
    this.title,
    this.secondary,
    this.padding,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: CheckboxListTile(
        onChanged: this.onChanged,
        value: value,
        title: this.title != null ? Text(this.title!) : null,
        secondary: this.secondary,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
