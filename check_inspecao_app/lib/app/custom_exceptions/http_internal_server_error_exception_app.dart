import 'package:check_inspecao_app/app/custom_exceptions/exception_app.dart';

class HttpInternalServerErrorApp extends ExceptionApp {
  final statusCode = 500;
  final statusMessage = 'Internal Server Error';
  HttpInternalServerErrorApp(String? message, {String? details = ''}) : super(message, details: details);
}
