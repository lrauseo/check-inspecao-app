// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subGrupos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SubGruposController on _SubGruposStoreBase, Store {
  final _$itensAtom = Atom(name: '_SubGruposStoreBase.itens');

  @override
  ObservableList<ItemInspecaoModel> get itens {
    _$itensAtom.reportRead();
    return super.itens;
  }

  @override
  set itens(ObservableList<ItemInspecaoModel> value) {
    _$itensAtom.reportWrite(value, super.itens, () {
      super.itens = value;
    });
  }

  final _$_itemSelecionadoAtom =
      Atom(name: '_SubGruposStoreBase._itemSelecionado');

  @override
  ItemInspecaoModel? get _itemSelecionado {
    _$_itemSelecionadoAtom.reportRead();
    return super._itemSelecionado;
  }

  @override
  set _itemSelecionado(ItemInspecaoModel? value) {
    _$_itemSelecionadoAtom.reportWrite(value, super._itemSelecionado, () {
      super._itemSelecionado = value;
    });
  }

  final _$buscarItensAsyncAction =
      AsyncAction('_SubGruposStoreBase.buscarItens');

  @override
  Future buscarItens(GrupoModel grupo) {
    return _$buscarItensAsyncAction.run(() => super.buscarItens(grupo));
  }

  final _$salvarSubGrupoAsyncAction =
      AsyncAction('_SubGruposStoreBase.salvarSubGrupo');

  @override
  Future salvarSubGrupo() {
    return _$salvarSubGrupoAsyncAction.run(() => super.salvarSubGrupo());
  }

  @override
  String toString() {
    return '''
itens: ${itens}
    ''';
  }
}
