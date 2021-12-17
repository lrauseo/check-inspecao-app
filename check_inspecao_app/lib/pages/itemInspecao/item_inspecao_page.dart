import 'dart:typed_data';

import 'package:check_inspecao_app/models/item_documento_model.dart';
import 'package:check_inspecao_app/models/opcao_inspecao_enum.dart';
import 'package:check_inspecao_app/pages/documentos/documentos_controller.dart';
import 'package:check_inspecao_app/pages/itemInspecao/item_inspecao_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class ItemInspecaoPage extends StatefulWidget {
  final int _grupoId;

  ItemInspecaoPage(this._grupoId);

  @override
  _ItemInspecaoPageState createState() => _ItemInspecaoPageState();
}

class _ItemInspecaoPageState extends State<ItemInspecaoPage> {
  var _controller = Modular.get<ItemInspecaoController>();
  var _documentosController = Modular.get<DocumentosController>();

  TextEditingController _txtControlerObs = TextEditingController();

  @override
  void dispose() {
    _txtControlerObs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.setDocumentoAtual(_documentosController.documentoAtual);

    return Scaffold(
        appBar: AppBar(
          title: Text("Item Inspecao"),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () async {
                  var erros = _controller.validaItens(_controller.itensDocumento);
                  // if (erros.length > 0) {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //       backgroundColor: Colors.red,
                  //       content: Text("Existem itens não marcados !")));
                  //   return;
                  // }
                  var doc = await _documentosController.salvarDocumento(_controller.itensDocumento);

                  if (doc != null) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Itens Salvos com sucesso!")));
                    _controller.setDocumentoAtual(null);
                    Modular.to.pop(true);
                  }
                }),
          ],
        ),
        body: FutureBuilder<List<ItemDocumentoModel>>(
            future: _controller.listaItens(widget._grupoId),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, idx) {
                      _txtControlerObs =
                          TextEditingController(text: _controller.itensDocumento[idx].observacao);
                      return Column(
                        children: [
                          Card(
                            elevation: 4,
                            margin: EdgeInsets.all(5),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                    width: MediaQuery.of(context).size.width,
                                    child: Observer(builder: (_) {
                                      return Text(
                                        "Classificação: ${_controller.itensDocumento[idx].itemInspecao?.classificacao}",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      );
                                    }),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(width: 2, color: Colors.blue.shade100))),
                                    child: Observer(builder: (_) {
                                      return Text(
                                          "Descrição: ${_controller.itensDocumento[idx].itemInspecao?.descricao}");
                                    }),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Observer(builder: (_) {
                                              return Checkbox(
                                                  value: _controller.itensDocumento[idx].sim ?? false,
                                                  onChanged: (checked) {
                                                    var item = _controller.itensDocumento[idx];
                                                    _controller.setOpcaoInspecao(item, OpcaoInspecao.sim);
                                                  });
                                            }),
                                            Text("Sim")
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Observer(builder: (_) {
                                              return Checkbox(
                                                  value: _controller.itensDocumento[idx].nao ?? false,
                                                  onChanged: (checked) {
                                                    var item = _controller.itensDocumento[idx];
                                                    _controller.setOpcaoInspecao(item, OpcaoInspecao.nao);
                                                  });
                                            }),
                                            Text("Não")
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Observer(builder: (_) {
                                              return Checkbox(
                                                  value: _controller.itensDocumento[idx].naoSeAplica ?? false,
                                                  onChanged: (checked) {
                                                    var item = _controller.itensDocumento[idx];
                                                    _controller.setOpcaoInspecao(
                                                        item, OpcaoInspecao.naoSeAplica);
                                                  });
                                            }),
                                            Text("NA")
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Observer(builder: (_) {
                                            return Checkbox(
                                                value: _controller.itensDocumento[idx].naoObservado ?? false,
                                                onChanged: (checked) {
                                                  var item = _controller.itensDocumento[idx];
                                                  _controller.setOpcaoInspecao(
                                                      item, OpcaoInspecao.naoObservado);
                                                });
                                          }),
                                          Text("NO")
                                        ],
                                      )),
                                    ],
                                  ),
                                  TextField(
                                    controller: _txtControlerObs = TextEditingController(
                                        text: _controller.itensDocumento[idx].observacao),
                                    onChanged: (value) {
                                      _controller.itensDocumento[idx].observacao = value;

                                      // _controller.addItemDocumento(
                                      //     _controller.itensDocumento[idx]);

                                      this._txtControlerObs.selection = TextSelection.fromPosition(
                                          TextPosition(offset: _txtControlerObs.text.length));
                                    },

                                    decoration: InputDecoration(hintText: "Observação"),
                                    // controller: _txtObservacaoCtrl,
                                    textCapitalization: TextCapitalization.characters,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z 0-9]"))
                                    ],
                                    // onChanged: (value) =>
                                    //     controller.setObs(value)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: SizedBox(
                                      height: 40.0,
                                      child: Observer(builder: (_) {
                                        return ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: _listaFotos(
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    await _tirarFoto(_controller.itensDocumento[idx]);
                                                  },
                                                  child: Icon(Icons.add_a_photo)),
                                              _controller.itensDocumento[idx]),
                                        );
                                      }),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    });
              }
            }));
  }

  List<Widget> _listaFotos(Widget primeiroItem, ItemDocumentoModel item) {
    List<Widget> lista = <Widget>[];
    lista.add(primeiroItem);
    // lista.add(Padding(
    //   padding: const EdgeInsets.all(2.0),
    //   child: Image.network(
    //       "https://weneedfun.com/wp-content/uploads/2015/10/Sports-car-16.jpg"),
    // ));

    item.fotos?.forEach((element) {
      if (element.arquivo == null) item.fotos?.remove(element);
    });

    item.fotos?.forEach((e) => lista.add(InkWell(
        onTap: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            // var file = XFile(e.arquivo);

                            Navigator.pop(context);
                            Uint8List imagem = await Modular.to
                                .pushNamed('/MostrarImagem', arguments: e.arquivo) as Uint8List;
                            if (imagem != null) {
                              _controller.excluirFoto(item, e);
                              _controller.addFoto(item, imagem);
                            }
                          },
                          child: Text('Visualizar')),
                      TextButton(
                          onPressed: () {
                            _controller.excluirFoto(item, e);
                            Navigator.pop(context);
                          },
                          child: Text('Excluir'))
                    ],
                  ),
                );
              });
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: e.arquivo != null ? Image.memory(e.arquivo!) : null,
        ))));
    return lista;
  }

  _tirarFoto(ItemDocumentoModel item) async {
    await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      Modular.to.pop();
                      PickedFile? pickedFile = await ImagePicker().getImage(
                        source: ImageSource.camera,
                        maxWidth: 1800,
                        maxHeight: 1800,
                        imageQuality: 25,
                      );
                      if (pickedFile != null) {
                        Uint8List data = await pickedFile.readAsBytes();
                        Uint8List imagem =
                            await Modular.to.pushNamed('/MostrarImagem', arguments: data) as Uint8List;
                        if (imagem != null) _controller.addFoto(item, imagem);
                      }
                    },
                    child: Text('Tirar Foto')),
                TextButton(
                    onPressed: () async {
                      Modular.to.pop();
                      PickedFile? pickedFile = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                        maxWidth: 1800,
                        maxHeight: 1800,
                        imageQuality: 25,
                      );
                      if (pickedFile != null) {
                        Uint8List data = await pickedFile.readAsBytes();
                        _controller.addFoto(item, data);
                      }
                    },
                    child: Text('Mostrar Galeria'))
              ],
            ),
          );
        });
  }
}
