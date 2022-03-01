import 'package:flutter/foundation.dart';

class ExceptionApp implements Exception {
  final String? message;
  final String? details;
  ExceptionApp(this.message, {this.details = ''}) {
    debugPrint('${this.message} - ${this.details}');
  }

  @override
  String toString() {
    if (this.message == null) return "Exception";
    return message!;
  }
}
