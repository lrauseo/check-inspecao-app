import 'package:check_inspecao_app/models/documento_model.dart';
import 'package:check_inspecao_app/pages/documentos/documentos_controller.dart';
import 'package:check_inspecao_app/widgets/menu_drawer_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class DocumentosPage extends StatefulWidget {
  @override
  _DocumentosPageState createState() => _DocumentosPageState();
}

class _DocumentosPageState extends State<DocumentosPage> {
  @override
  Widget build(BuildContext context) {
    final _controller = Modular.get<DocumentosController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Documentos "),
        actions: [
          IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () async {
                await _controller.novoDocumento(1, 1);
              }),
        ],
      ),
      drawer: MenuDrawerPrincipal(),
      body: FutureBuilder<List<DocumentoModel>>(
        future: _controller.getDocumentos(1, 1),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
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
                    trailing: Text(DateFormat('dd/MM/yyyy').format(snapshot.data![index].dataDocumento!)),
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
