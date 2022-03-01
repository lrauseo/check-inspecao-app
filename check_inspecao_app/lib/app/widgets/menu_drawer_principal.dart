import 'package:check_inspecao_app/constantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        Container(
          child: DrawerHeader(
            child: Center(
                child: Text(
              'Menu Principal',
              style: Theme.of(context).textTheme.headline5,
            )),
          ),
          color: Theme.of(context).primaryColor,
        ),
        ListTile(
          title: Text('Perfil'),
          leading: Icon(Icons.person),
          onTap: () => Modular.to.pushNamed('/Perfil'),
        ),
        ListTile(
          title: const Text('Categorias'),
          leading: const Icon(Icons.person),
          onTap: () => Modular.to.pushNamed(
            '/Grupos/true',
          ),
        ),
        // ListTile(
        //   title: Text('Assinatura'),
        //   leading: Icon(Icons.person),
        //   onTap: () => Modular.to.pushNamed('/Assinatura'),
        // ),
        ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () {
              SharedPreferences.getInstance().then((value) {
                value.remove(ConstsSharedPreferences.perfil);
                value.remove(ConstsSharedPreferences.usuarioAuth);
                Modular.to.pushReplacementNamed('/');
              });
            }),
        // popUntil(ModalRoute.withName("/"))),
      ],
    ));
  }
}
