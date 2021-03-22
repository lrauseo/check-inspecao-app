import 'package:flutter/material.dart';

class PerfilUsuarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuário'),
      ),
      body: CustomPaint(
        child: Center(
          child: Text(
            'Once upon a time...',
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
