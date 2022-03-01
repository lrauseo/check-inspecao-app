import 'package:check_inspecao_app/app/custom_exceptions/exception_app.dart';

class HttpUnauthorizedExceptionApp extends ExceptionApp {
  final statusCode = 401;
  final statusMessage = 'Unauthorized';
  HttpUnauthorizedExceptionApp(String? message) : super(message);
}
