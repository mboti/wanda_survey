import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';


class DataServer extends StatefulWidget {

  @override
  State<DataServer> createState() {
    return new DataServerState();
  }

}

class DataServerState extends State<DataServer>{

  GlobalKey globalKey = GlobalKey();



  Project project = Project();
  //final json = Project().toJson();
  static final json = Project().toJson();
  //File jsonFile;
  //Directory dir;
  //String json = "myFile.json";




  @override
  initState(){
    createDir();
    super.initState();
    project;
    json;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }



  ///==================================================================================================
  ///    PARTIE DEDIEE A CREER/ECRIRE/LIRE LE DATA.JSON
  ///==================================================================================================



   //1- Find the corect local path
   //2- Create a refernce to the file location
   //3- Write data to the file
   //4- Read data from the file

  //1- Find the corect local path
  Future<String> get localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 2- Create a refernce to the file location
  Future<File> get localFile async{
    final path = await localPath;
    //return File("$file/data.txt");
    return File("$path/data.json");
  }


  // 3- Write data to the file
  Future<File> writeData() async{ //double will be an Object
    final json2 = json;
    final file = await localFile;
    print('----------etage_______');

   //return file.writeAsString(displayTojson());
    return file.writeAsString('$json2.');
  }

  // 4- Read data from the file
  Future<double> readData() async{
    try{
      final file = await localFile;
      String data = await file.readAsString();
      return double.parse(data);
    } catch(e){
      return 0;
    }
  }


  ///==================================================================================================
  ///    PARTIE DEDIEE A CREER LE DOSSIER
  ///==================================================================================================


  createDir() async {
    print("----------in createDir----------");
    //Directory? baseDir = await getExternalStorageDirectory(); //only for Android
    String baseDir = (await getApplicationDocumentsDirectory()).path; //works for both iOS and Android
    String dirToBeCreated = "<your_dir_name>";
    //String dirToBeCreatede = "storage/emulated/0/<your_dir_name>";
    String finalDir = join(baseDir, dirToBeCreated);
    var dir = Directory(finalDir);
    bool dirExists = await dir.exists();
    if(!dirExists){
      dir.create(/*recursive=true*/); //pass recursive as true if directory is recursive
    }
    //Now you can use this directory for saving file, etc.
    //In case you are using external storage, make sure you have storage permissions.
  }

  ///==================================================================================================
  ///    PARTIE DEDIEE A GENERER LE JSON
  ///==================================================================================================


  ///static final json = Project().toJson();
  displayTojson(){
    final json2 = json;
  /*  String v1 = json2.values.first;
    String v1prime = json2.values.elementAt(0);
    String v2 = json2.values.elementAt(1);
    String v3 = json2.values.elementAt(2);
    String v4 = json2.values.elementAt(3);
    String v5 = json2.values.elementAt(4);
    String v6 = json2.values.elementAt(5);
    String v7 = json2.values.elementAt(6);
    String v8 = json2.values.elementAt(7);
    String v9 = json2.values.elementAt(8);*/
    //Map <String, dynamic> p;

    Map <String, dynamic> p = json2;
    var list = [];
    //var newObj = p.forEach((key, value) {print(key); print(value);});
    //var newObj = p.entries.forEach((element) { print(element); });
    //var newObj = p.entries.forEach((element) { print(element.key); });
    //var newObj = p.entries.forEach((element) { print(element.value); });
    var newObj = p.entries.map((elm) { return elm.key ; }).toList();
    //var newObj = p.entries.map((elm) { return   ;}).toList();

    //list.add(newObj);
    //return newObj;
    return newObj.toString();

    //print('ProjectJson, meth toJson: $p');
    //print('ProjectJson, meth toJson: ${Project().toJson()}');
    //return json2.forEach((key, value) {project.floors.first.ruler.rateRulerVsW});
    //return json2.forEach((key, value) {print(json.entries.toString());});
  }

  final newProject = Project.fromJson(json);
  displayFromJson(){
    print('ProjectJson, meth fromJson: $newProject');
  }



  ///===================================================
  /// Enregistrer suivant les contraintes du projet
  ///===================================================

  //1- how can save some field of my class to json file using json_serialisable
  //2-flutter: How to select a single field from json serialization with json_serializable?
  //3- https://github.com/bramvbilsen/Flutter-JSON-Storage-Tutorial/blob/master/lib/main.dart



////////////////////////////////////// TESST  1  1 2 1 2 1 2 1 2 1 2//////////////////////
  /*Future<String>  createFolderInAppDocDir (String nom_dossier) async {

      //Obtenir ce répertoire de documents d'application
      répertoire final _appDocDir =  attendre  getApplicationDocumentsDirectory ();
      // Répertoire de documents d'application + nom de dossier
      Répertoire final _appDocDirFolder =   Répertoire ( ' ${ _appDocDir . path } /$ nom_dossier /' );

      if ( await _appDocDirFolder. exists ()){ //si le dossier existe déjà, retourner le chemin
        renvoie _appDocDirFolder.path ;
      } else { //si le dossier n'existe pas créer le dossier puis retourner son chemin
        Répertoire final _appDocDirNewFolder = attendre _appDocDirFolder. créer (récursif :  true );
        return _appDocDirNewFolder.path ;
      }
    }*/

// Methode permettant de sauver le custum painter (la scène) dans la galerie
   Future<void> save() async {
    print("in the _save fun");
    RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    //Request permissions if not already granted
    //if (!(await Permission.storage.status.isGranted))
    //await Permission.storage.request();

    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(pngBytes),
        quality: 60,
        name: "canvas_image");
    print(result);
  }



}//Fin
