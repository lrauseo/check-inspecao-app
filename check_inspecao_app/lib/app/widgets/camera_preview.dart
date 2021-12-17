import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_editor/image_editor.dart';

class TakePictureScreen extends StatefulWidget {
  // final camera = Modular.get<CameraDescription>();
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controllerCamera;
  late int turns;
  late Orientation telaOrientation;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the camera,
    // create a CameraController.
    // _controllerCamera = CameraController(
    //   // Get a specific camera from the list of available cameras.
    //   widget.camera,
    //   // Define the resolution to use.
    //   ResolutionPreset.medium,
    // );
    // // Next, initialize the controller. This returns a Future.
    // _initializeControllerFuture = _controllerCamera.initialize();

    turns = 0;
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controllerCamera.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              // return CameraPreview(_controllerCamera);
              return OrientationBuilder(builder: (context, orientation) {
                switch (orientation) {
                  case Orientation.portrait:
                    {
                      if (telaOrientation == null) {
                        turns = 0;
                        telaOrientation = Orientation.portrait;
                      } else if (telaOrientation != orientation) {
                        turns = turns == 0 ? 1 : 4;
                        telaOrientation = Orientation.portrait;
                      } else {
                        turns = 0;
                      }
                    }

                    break;
                  case Orientation.landscape:
                    {
                      if (telaOrientation == null) {
                        turns = 0;
                        telaOrientation = Orientation.landscape;
                      } else if (telaOrientation != orientation) {
                        turns = turns == 1 ? 3 : 2;
                        telaOrientation = Orientation.landscape;
                      } else {
                        turns = 0;
                      }
                    }
                    break;
                  default:
                    turns = 0;
                    break;
                }

                return CameraPreview(_controllerCamera);
              });
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controllerCamera.takePicture();

            Uint8List data = await image.readAsBytes();
            var imagem = await Modular.to.pushNamed<Uint8List>('/MostrarImagem', arguments: data);
            if (imagem != null) Modular.to.pop<Uint8List>(imagem);
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final Uint8List imagePath;
  Uint8List? imageFile;
  DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key) {
    imageFile = imagePath;
  }

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  final editorOption = ImageEditorOption();
  // editorOption.addOption(FlipOption());
  // editorOption.addOption(ClipOption(x:0,y:0,width: 1920, height: 1920));
  // editorOption.addOption(RotateOption(180));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edição da Imagem'),
          actions: [
            IconButton(
                icon: Icon(Icons.rotate_right),
                onPressed: () async {
                  editorOption.addOption(RotateOption(90));

                  widget.imageFile =
                      await ImageEditor.editImage(image: widget.imageFile!, imageEditorOption: editorOption);
                  setState(() {
                    editorOption.reset();
                  });
                }),
            IconButton(
              onPressed: () {
                Modular.to.pop<Uint8List>(widget.imageFile!);
              },
              icon: Icon(Icons.check),
            )
          ],
        ),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: widget.imageFile != null ? Center(child: Image.memory(widget.imageFile!)) : null);
  }
}
