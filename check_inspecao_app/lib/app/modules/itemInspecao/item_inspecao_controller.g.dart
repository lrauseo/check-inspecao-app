// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_inspecao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemInspecaoController on _ItemInspecaoControllerBase, Store {
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

  final _$itemSelecionadoAtom =
      Atom(name: '_ItemInspecaoControllerBase.itemSelecionado');

  @override
  ItemDocumentoModel? get itemSelecionado {
    _$itemSelecionadoAtom.reportRead();
    return super.itemSelecionado;
  }

  @override
  set itemSelecionado(ItemDocumentoModel? value) {
    _$itemSelecionadoAtom.reportWrite(value, super.itemSelecionado, () {
      super.itemSelecionado = value;
    });
  }

  final _$_ItemInspecaoControllerBaseActionController =
      ActionController(name: '_ItemInspecaoControllerBase');

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
documentoAtual: ${documentoAtual},
itemSelecionado: ${itemSelecionado}
    ''';
  }
}
