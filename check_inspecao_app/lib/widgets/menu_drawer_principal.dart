import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MenuDrawerPrincipal extends StatelessWidget {
  // String title;
  // DrawerHeader header;
  // List<Widget> items;
  // MenuDrawerPrincipal({this.header, this.items});
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Center(child: Text('Menu Principal')),
        ),
        ListTile(
          title: Text('Perfil'),
          leading: Icon(Icons.person),
          onTap: () => Modular.to.pushNamed('/Perfil'),
        ),
        ListTile(
          title: Text('Assinatura'),
          leading: Icon(Icons.person),
          onTap: () => Modular.to.pushNamed('/Assinatura'),
        ),
        ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () => Modular.to.pushReplacementNamed('/')),
        // popUntil(ModalRoute.withName("/"))),
      ],
    ));
  }
}
