import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FormTextFieldStandard extends StatelessWidget {
  final bool isPassword;
  final TextEditingController controller;
  final EdgeInsets? padding;
  final String? Function(String?)? validator;
  final String? placheholder;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const FormTextFieldStandard({
    Key? key,
    this.isPassword = false,
    required this.controller,
    this.padding,
    this.validator,
    this.placheholder,
    this.textInputAction = TextInputAction.done,
    this.maxLength,
    this.inputFormatters,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextFormField(
        maxLength: maxLength,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        decoration: this.placheholder != null
            ? InputDecoration(hintText: this.placheholder)
            : null,
        controller: controller,
        obscureText: isPassword,
        validator: validator,
      ),
    );
  }
}
