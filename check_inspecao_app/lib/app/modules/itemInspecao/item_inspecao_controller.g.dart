// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_inspecao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemInspecaoController on _ItemInspecaoControllerBase, Store {
  final _$exceptionAppAtom =
      Atom(name: '_ItemInspecaoControllerBase.exceptionApp');

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

  final _$loadingAtom = Atom(name: '_ItemInspecaoControllerBase.loading');

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

  final _$documentoAtualAtom =
      Atom(name: '_ItemInspecaoControllerBase.documentoAtual');

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

  final _$listaItensAsyncAction =
      AsyncAction('_ItemInspecaoControllerBase.listaItens');

  @override
  Future listaItens(int? formularioId) {
    return _$listaItensAsyncAction.run(() => super.listaItens(formularioId));
  }

  final _$_ItemInspecaoControllerBaseActionController =
      ActionController(name: '_ItemInspecaoControllerBase');

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_ItemInspecaoControllerBaseActionController
        .startAction(name: '_ItemInspecaoControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ItemInspecaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDocumentoAtual(DocumentoModel? doc) {
    final _$actionInfo = _$_ItemInspecaoControllerBaseActionController
        .startAction(name: '_ItemInspecaoControllerBase.setDocumentoAtual');
    try {
      return super.setDocumentoAtual(doc);
    } finally {
      _$_ItemInspecaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic criaItemDocumento(List<ItemInspecaoModel> itens) {
    final _$actionInfo = _$_ItemInspecaoControllerBaseActionController
        .startAction(name: '_ItemInspecaoControllerBase.criaItemDocumento');
    try {
      return super.criaItemDocumento(itens);
    } finally {
      _$_ItemInspecaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addItemDocumento(ItemDocumentoModel item) {
    final _$actionInfo = _$_ItemInspecaoControllerBaseActionController
        .startAction(name: '_ItemInspecaoControllerBase.addItemDocumento');
    try {
      return super.addItemDocumento(item);
    } finally {
      _$_ItemInspecaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setOpcaoInspecao(ItemDocumentoModel item, OpcaoInspecao opcao) {
    final _$actionInfo = _$_ItemInspecaoControllerBaseActionController
        .startAction(name: '_ItemInspecaoControllerBase.setOpcaoInspecao');
    try {
      return super.setOpcaoInspecao(item, opcao);
    } finally {
      _$_ItemInspecaoControllerBaseActionController.endAction(_$actionInfo);
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
