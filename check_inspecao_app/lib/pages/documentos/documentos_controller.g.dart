// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documentos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DocumentosController on _DocumentosControllerBase, Store {
  final _$documentoAtualAtom =
      Atom(name: '_DocumentosControllerBase.documentoAtual');

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
      AsyncAction('_DocumentosControllerBase.novoDocumento');

  @override
  Future novoDocumento(int usuarioId, int clienteId) {
    return _$novoDocumentoAsyncAction
        .run(() => super.novoDocumento(usuarioId, clienteId));
  }

  @override
  String toString() {
    return '''
documentoAtual: ${documentoAtual}
    ''';
  }
}
