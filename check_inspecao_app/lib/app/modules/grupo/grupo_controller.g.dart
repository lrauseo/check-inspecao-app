// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grupo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GrupoController on _GrupoControllerBase, Store {
  final _$exceptionAppAtom = Atom(name: '_GrupoControllerBase.exceptionApp');

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

  final _$loadingAtom = Atom(name: '_GrupoControllerBase.loading');

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

  final _$grupoAtualAtom = Atom(name: '_GrupoControllerBase.grupoAtual');

  @override
  GrupoModel? get grupoAtual {
    _$grupoAtualAtom.reportRead();
    return super.grupoAtual;
  }

  @override
  set grupoAtual(GrupoModel? value) {
    _$grupoAtualAtom.reportWrite(value, super.grupoAtual, () {
      super.grupoAtual = value;
    });
  }

  final _$listaGruposAsyncAction =
      AsyncAction('_GrupoControllerBase.listaGrupos');

  @override
  Future listaGrupos() {
    return _$listaGruposAsyncAction.run(() => super.listaGrupos());
  }

  final _$goToItensInspecaoAsyncAction =
      AsyncAction('_GrupoControllerBase.goToItensInspecao');

  @override
  Future goToItensInspecao(GrupoModel grupo) {
    return _$goToItensInspecaoAsyncAction
        .run(() => super.goToItensInspecao(grupo));
  }

  final _$salvarGrupoAsyncAction =
      AsyncAction('_GrupoControllerBase.salvarGrupo');

  @override
  Future<GrupoModel?> salvarGrupo() {
    return _$salvarGrupoAsyncAction.run(() => super.salvarGrupo());
  }

  final _$novoGrupoAsyncAction = AsyncAction('_GrupoControllerBase.novoGrupo');

  @override
  Future novoGrupo() {
    return _$novoGrupoAsyncAction.run(() => super.novoGrupo());
  }

  final _$_GrupoControllerBaseActionController =
      ActionController(name: '_GrupoControllerBase');

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_GrupoControllerBaseActionController.startAction(
        name: '_GrupoControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_GrupoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
exceptionApp: ${exceptionApp},
loading: ${loading},
grupoAtual: ${grupoAtual}
    ''';
  }
}
