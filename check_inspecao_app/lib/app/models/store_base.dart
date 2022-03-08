import 'package:check_inspecao_app/app/custom_exceptions/exception_app.dart';
import 'package:mobx/mobx.dart';

class _StoreBase {
  @observable
  ExceptionApp? exceptionApp;
  @observable
  bool loading = false;
  @action
  setLoading(bool value) => loading = value;
}
