// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$exceptionAppAtom = Atom(name: '_HomeControllerBase.exceptionApp');

  @override
  ExceptionApp? get exceptionApp {
    _$exceptionAppAtom.reportRead();
    return super.exceptionApp;
  }

  @override
  set exceptionApp(ExceptionApp? value) {
    _$exceptionAppAtom.reportWrite(value, super.exceptionApp, () {
      super.exceptionApp = value;
    });
  }

  final _$loadingAtom = Atom(name: '_HomeControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$documentoAtualAtom = Atom(name: '_HomeControllerBase.documentoAtual');

  @override
  DocumentoModel? get documentoAtual {
    _$documentoAtualAtom.reportRead();
    return super.documentoAtual;
  }

  @override
  set documentoAtual(DocumentoModel? value) {
    _$documentoAtualAtom.reportWrite(value, super.documentoAtual, () {
      super.documentoAtual = value;
    });
  }

  final _$novoDocumentoAsyncAction =
      AsyncAction('_HomeControllerBase.novoDocumento');

  @override
  Future novoDocumento(int clienteId) {
    return _$novoDocumentoAsyncAction.run(() => super.novoDocumento(clienteId));
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
exceptionApp: ${exceptionApp},
loading: ${loading},
documentoAtual: ${documentoAtual}
    ''';
  }
}
