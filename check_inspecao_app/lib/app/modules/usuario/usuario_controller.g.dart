// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsuarioController on _UsuarioControllerBase, Store {
  final _$usuarioAtom = Atom(name: '_UsuarioControllerBase.usuario');

  @override
  UsuarioModel? get usuario {
    _$usuarioAtom.reportRead();
    return super.usuario;
  }

  @override
  set usuario(UsuarioModel? value) {
    _$usuarioAtom.reportWrite(value, super.usuario, () {
      super.usuario = value;
    });
  }

  final _$salvarUsuarioAsyncAction =
      AsyncAction('_UsuarioControllerBase.salvarUsuario');

  @override
  Future<bool> salvarUsuario() {
    return _$salvarUsuarioAsyncAction.run(() => super.salvarUsuario());
  }

  final _$_UsuarioControllerBaseActionController =
      ActionController(name: '_UsuarioControllerBase');

  @override
  dynamic setUsuario(UsuarioModel usuario) {
    final _$actionInfo = _$_UsuarioControllerBaseActionController.startAction(
        name: '_UsuarioControllerBase.setUsuario');
    try {
      return super.setUsuario(usuario);
    } finally {
      _$_UsuarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
usuario: ${usuario}
    ''';
  }
}
