// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionario_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuestionarioController on _QuestionarioControllerBase, Store {
  Computed<bool?>? _$itemCheckedComputed;

  @override
  bool? get itemChecked =>
      (_$itemCheckedComputed ??= Computed<bool?>(() => super.itemChecked,
              name: '_QuestionarioControllerBase.itemChecked'))
          .value;

  final _$exceptionAppAtom =
      Atom(name: '_QuestionarioControllerBase.exceptionApp');

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

  final _$loadingAtom = Atom(name: '_QuestionarioControllerBase.loading');

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

  final _$todosSelecionadosAtom =
      Atom(name: '_QuestionarioControllerBase.todosSelecionados');

  @override
  bool get todosSelecionados {
    _$todosSelecionadosAtom.reportRead();
    return super.todosSelecionados;
  }

  @override
  set todosSelecionados(bool value) {
    _$todosSelecionadosAtom.reportWrite(value, super.todosSelecionados, () {
      super.todosSelecionados = value;
    });
  }

  final _$itensSelecaoTelaAtom =
      Atom(name: '_QuestionarioControllerBase.itensSelecaoTela');

  @override
  ObservableMap<int, dynamic> get itensSelecaoTela {
    _$itensSelecaoTelaAtom.reportRead();
    return super.itensSelecaoTela;
  }

  @override
  set itensSelecaoTela(ObservableMap<int, dynamic> value) {
    _$itensSelecaoTelaAtom.reportWrite(value, super.itensSelecaoTela, () {
      super.itensSelecaoTela = value;
    });
  }

  final _$questionarioSelecionadoAtom =
      Atom(name: '_QuestionarioControllerBase.questionarioSelecionado');

  @override
  QuestionarioFormularioModel? get questionarioSelecionado {
    _$questionarioSelecionadoAtom.reportRead();
    return super.questionarioSelecionado;
  }

  @override
  set questionarioSelecionado(QuestionarioFormularioModel? value) {
    _$questionarioSelecionadoAtom
        .reportWrite(value, super.questionarioSelecionado, () {
      super.questionarioSelecionado = value;
    });
  }

  final _$buscarQuestionariosAsyncAction =
      AsyncAction('_QuestionarioControllerBase.buscarQuestionarios');

  @override
  Future buscarQuestionarios() {
    return _$buscarQuestionariosAsyncAction
        .run(() => super.buscarQuestionarios());
  }

  final _$novoQuestionarioAsyncAction =
      AsyncAction('_QuestionarioControllerBase.novoQuestionario');

  @override
  Future novoQuestionario() {
    return _$novoQuestionarioAsyncAction.run(() => super.novoQuestionario());
  }

  final _$editarQuestionarioAsyncAction =
      AsyncAction('_QuestionarioControllerBase.editarQuestionario');

  @override
  Future editarQuestionario() {
    return _$editarQuestionarioAsyncAction
        .run(() => super.editarQuestionario());
  }

  final _$salvarQuestionarioAsyncAction =
      AsyncAction('_QuestionarioControllerBase.salvarQuestionario');

  @override
  Future salvarQuestionario() {
    return _$salvarQuestionarioAsyncAction
        .run(() => super.salvarQuestionario());
  }

  final _$addNovoItemQuestionarioAsyncAction =
      AsyncAction('_QuestionarioControllerBase.addNovoItemQuestionario');

  @override
  Future addNovoItemQuestionario() {
    return _$addNovoItemQuestionarioAsyncAction
        .run(() => super.addNovoItemQuestionario());
  }

  final _$_QuestionarioControllerBaseActionController =
      ActionController(name: '_QuestionarioControllerBase');

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_QuestionarioControllerBaseActionController
        .startAction(name: '_QuestionarioControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_QuestionarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic selecionarTodos() {
    final _$actionInfo = _$_QuestionarioControllerBaseActionController
        .startAction(name: '_QuestionarioControllerBase.selecionarTodos');
    try {
      return super.selecionarTodos();
    } finally {
      _$_QuestionarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
exceptionApp: ${exceptionApp},
loading: ${loading},
todosSelecionados: ${todosSelecionados},
itensSelecaoTela: ${itensSelecaoTela},
questionarioSelecionado: ${questionarioSelecionado},
itemChecked: ${itemChecked}
    ''';
  }
}
