import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signature/signature.dart';
import 'dart:ui' as ui;

class SignatureDraw extends StatefulWidget {
  const SignatureDraw({Key? key}) : super(key: key);

  @override
  _SignatureDrawState createState() => _SignatureDrawState();
}

class _SignatureDrawState extends State<SignatureDraw> {
  final _signatureController = SignatureController(
    penStrokeWidth: 4.0,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void initState() {
    _portraitModeOnly();
    _signatureController.addListener(() => print('signature Value changed'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Assinatura'),
          //actions: [IconButton(icon: const Icon(Icons.save), onPressed: () {})],
        ),
        body: ListView(children: [
          // Container(
          //   height: 300,
          //   child: const Center(
          //     child: Text('Big container to test scrolling issues'),
          //   ),
          // ),
          //SIGNATURE CANVAS
          Signature(
            controller: _signatureController,
            height: MediaQuery.of(context).size.height - 130,
            backgroundColor: Colors.lightBlueAccent,
          ),
          //OK AND CLEAR BUTTONS
          Container(
              height: 50,
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //SHOW EXPORTED IMAGE IN NEW ROUTE
                  IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.check),
                    color: Colors.blue,
                    onPressed: () async {
                      if (_signatureController.isNotEmpty) {
                        // final img = await _signatureController.toImage();
                        // final pngBytes = await img?.toByteData(format: ui.ImageByteFormat.png);
                        // var data = Uint8List.view(pngBytes!.buffer);
                        // var imagem = await Modular.to.pushNamed('/MostrarImagem', arguments: data);
                        // if (imagem != null) Modular.to.pop(imagem);

                        final Uint8List? data = await _signatureController.toPngBytes();
                        if (data != null) {
                          var imagem = await Modular.to.pushNamed('/MostrarImagem', arguments: data);
                          if (imagem != null) Modular.to.pop(imagem);
                        }
                        // await Navigator.of(context).push(
                        //   MaterialPageRoute<void>(
                        //     builder: (BuildContext context) {
                        //       return Scaffold(
                        //         appBar: AppBar(),
                        //         body: Center(
                        //           child: Container(
                        //             color: Colors.grey[300],
                        //             child: Image.memory(data),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // );
                        //}
                      }
                    },
                  ),
                  //CLEAR CANVAS
                  IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.delete_forever),
                    color: Colors.blue,
                    onPressed: () {
                      setState(() => _signatureController.clear());
                    },
                  ),
                ],
              ))
        ]));
  }
}
