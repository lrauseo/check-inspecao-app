import 'package:check_inspecao_app/app/models/documento_model.dart';
import 'package:check_inspecao_app/app/modules/home/home_controller.dart';
import 'package:check_inspecao_app/app/widgets/menu_drawer_principal.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _controller = Modular.get<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Documentos "),
        actions: [
          IconButton(
              icon: const Icon(Icons.add_box),
              onPressed: () async {
                await _controller.novoDocumento(1);
              }),
        ],
      ),
      drawer: MenuDrawerPrincipal(),
      body: FutureBuilder<List<DocumentoModel>>(
        future: _controller.getDocumentos(1),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                // await _controller.getDocumentos(1, 1);
                setState(() {});
              },
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(snapshot.data![index].id.toString()),
                    title: Text(snapshot.data![index].cliente?.nome ?? ""),
                    //trailing: Text(DateFormat('dd/MM/yyyy').format(snapshot.data![index].dataDocumento!)),
                    onTap: () async {
                      _controller.documentoAtual =
                          await _controller.getDocumentoById(snapshot.data![index].id ?? 0);
                      await Modular.to.pushNamed("/Grupos");
                      setState(() {});
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
