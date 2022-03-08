import 'dart:typed_data';

import 'package:check_inspecao_app/app/models/item_documento_model.dart';
import 'package:check_inspecao_app/app/models/opcao_inspecao_enum.dart';
import 'package:check_inspecao_app/app/modules/home/home_controller.dart';
import 'package:check_inspecao_app/app/modules/itemInspecao/item_inspecao_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ItemInspecaoPage extends StatefulWidget {
  late int? formularioId;

  ItemInspecaoPage({this.formularioId, Key? key}) : super(key: key);

  @override
  _ItemInspecaoPageState createState() => _ItemInspecaoPageState();
}

class _ItemInspecaoPageState extends State<ItemInspecaoPage> {
  final _controller = Modular.get<ItemInspecaoController>();
  final _documentosController = Modular.get<HomeController>();

  TextEditingController _txtControlerObs = TextEditingController();

  @override
  void dispose() {
    _txtControlerObs.dispose();
    Modular.dispose<ItemInspecaoController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.setDocumentoAtual(_documentosController.documentoAtual);
    _controller.listaItens(widget.formularioId);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Inspecao"),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async {
                _controller.validaItens();
                // if (erros.length > 0) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //       backgroundColor: Colors.red,
                //       content: Text("Existem itens não marcados !")));
                //   return;
                // }
                var doc = await _documentosController.salvarDocumento();

                if (doc != null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Itens Salvos com sucesso!")));
                  Modular.to.pop(true);
                }
              }),
        ],
      ),
      body: Observer(builder: (_) {
        _controller.loading ? context.loaderOverlay.show() : context.loaderOverlay.hide();
        return ListView.builder(
            itemCount: _controller.documentoAtual?.itens!.length,
            itemBuilder: (_, idx) {
              _txtControlerObs =
                  TextEditingController(text: _controller.documentoAtual?.itens![idx].observacao);
              return Column(
                children: [
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: const BorderRadius.all(Radius.circular(20))),
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                            width: MediaQuery.of(context).size.width,
                            child: Observer(builder: (_) {
                              return Text(
                                "Classificação: ${_controller.documentoAtual?.itens![idx].itemInspecao?.classificacao}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              );
                            }),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 2, color: Colors.blue.shade100))),
                            child: Observer(builder: (_) {
                              return Text(
                                  "Descrição: ${_controller.documentoAtual?.itens![idx].itemInspecao?.descricao}");
                            }),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Observer(builder: (_) {
                                  return CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: const Text("Sim"),
                                      contentPadding: EdgeInsets.zero,
                                      value: _controller.documentoAtual?.itens![idx].sim ?? false,
                                      onChanged: (checked) {
                                        var item = _controller.documentoAtual?.itens![idx];
                                        _controller.setOpcaoInspecao(item!, OpcaoInspecao.sim);
                                      });
                                }),
                              ),
                              Expanded(
                                child: Observer(builder: (_) {
                                  return CheckboxListTile(
                                      title: const Text("Não"),
                                      contentPadding: EdgeInsets.zero,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      value: _controller.documentoAtual?.itens![idx].nao ?? false,
                                      onChanged: (checked) {
                                        var item = _controller.documentoAtual?.itens![idx];
                                        _controller.setOpcaoInspecao(item!, OpcaoInspecao.nao);
                                      });
                                }),
                              ),
                              Expanded(
                                child: Observer(builder: (_) {
                                  return CheckboxListTile(
                                      title: const Text("NA"),
                                      contentPadding: EdgeInsets.zero,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      value: _controller.documentoAtual?.itens![idx].naoSeAplica ?? false,
                                      onChanged: (checked) {
                                        var item = _controller.documentoAtual?.itens![idx];
                                        _controller.setOpcaoInspecao(item!, OpcaoInspecao.naoSeAplica);
                                      });
                                }),
                              ),
                              Expanded(
                                child: Observer(builder: (_) {
                                  return CheckboxListTile(
                                      title: const Text("NO"),
                                      contentPadding: EdgeInsets.zero,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      value: _controller.documentoAtual?.itens![idx].naoObservado ?? false,
                                      onChanged: (checked) {
                                        var item = _controller.documentoAtual?.itens![idx];
                                        _controller.setOpcaoInspecao(item!, OpcaoInspecao.naoObservado);
                                      });
                                }),
                              ),
                            ],
                          ),
                          TextField(
                            controller: _txtControlerObs = TextEditingController(
                                text: _controller.documentoAtual?.itens![idx].observacao ?? ''),
                            onChanged: (value) {
                              _controller.documentoAtual?.itens![idx].observacao = value;

                              // _controller.addItemDocumento(
                              //      _controller.documentoAtual?.itens![idx]);

                              this._txtControlerObs.selection = TextSelection.fromPosition(
                                  TextPosition(offset: _txtControlerObs.text.length));
                            },

                            decoration: const InputDecoration(hintText: "Observação"),
                            // controller: _txtObservacaoCtrl,
                            textCapitalization: TextCapitalization.characters,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z 0-9]"))],
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
                                            var item = _controller.documentoAtual?.itens![idx];
                                            await _tirarFoto(item!);
                                          },
                                          child: const Icon(Icons.add_a_photo)),
                                      _controller.documentoAtual!.itens![idx]),
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
      }),
    );
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
                          child: const Text('Visualizar')),
                      TextButton(
                          onPressed: () {
                            _controller.excluirFoto(item, e);
                            Navigator.pop(context);
                          },
                          child: const Text('Excluir'))
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
                    child: const Text('Tirar Foto')),
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
                    child: const Text('Mostrar Galeria'))
              ],
            ),
          );
        });
  }
}
