import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

/*void main() => runApp(new MaterialApp(
  home: new HomePage(),
  debugShowCheckedModeBanner: false,
));*/

class ComponentImportImage extends StatefulWidget {
  @override
  ComponentImportImageState createState() => new ComponentImportImageState();
}

class ComponentImportImageState extends State<ComponentImportImage> {


  String pathImage = "images/plan.jpg";

  final GlobalKey _key = GlobalKey();
  final GlobalKey globalKey = GlobalKey();
  double? _x, _y;

  File? imageFile;
  XFile? picture;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  /// afficher l'image selectionné

  Widget buildImageDisplayWidget(){
    //mainAxisAlignment : MainAxisAlignment.center;
    if(imageFile != null){ // Selection de notre image
      return  Container(
        //key: globalKey,
          child: buildImage()
      );
    }else{
      return Container(
        //width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        //margin: EdgeInsets.all(1.5),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          //border: Border.all(width: 8, color: Colors.black38),
          //borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
              image: AssetImage("images/plan.jpg"),
            ),
            color: Colors.black12
        ),
      );
    }
  }


  /// acceder à la camera
  _openCamera(BuildContext context) async{
    ImagePicker imagePicker = ImagePicker();
    var picture = await imagePicker.pickImage(source: ImageSource.camera);
    if(picture?.path != null){
      //this.setState(() {
      imageFile = File(picture!.path);
      //});
    }
    Navigator.of(context).pop();
  }

  /// acceder à la galerie
  _openGalery(BuildContext context) async{
    ImagePicker imagePicker = ImagePicker();
    var picture = await imagePicker.pickImage(source: ImageSource.gallery);
    if(picture?.path != null){
      //this.setState(() {
      imageFile = File(picture!.path);
      // });
    }
    Navigator.of(context).pop();
  }

  /// boite de dialoge pour choisir galerie/camera
  Future<void> buildShowDialogForChoiceCamOrGal(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Ouvrir"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ElevatedButton(
                child: Text("Camera"),
                onPressed: (){
                  //getImage(imageSource: ImageSource.gallery);
                  _openCamera(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              ElevatedButton(
                child: Text("Galerie"),
                onPressed: () {
                  //getImage(imageSource: ImageSource.gallery);
                  _openGalery(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }


  /// afficher l'image à selectionner camera/galerie permet de réaliser le zoom
  Widget buildImage () {
    return Container(
      //width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      //margin: EdgeInsets.all(1.5),
      //alignment: Alignment.center,
      decoration: BoxDecoration(
        //border: Border.all(width: 8, color: Colors.black38),
        //borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: FileImage(imageFile!),
          ),
          color: Colors.black12
      ),
    );
  }


  Future loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);

    //setState(() => this.image = image);
  }

}