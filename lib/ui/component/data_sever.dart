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

  @override
  initState(){
    createDir(); //call your method here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }


  /**
   * 1- Find the corect local path
   * 2- Create a refernce to the file location
   * 3- Write data to the file
   * 4- Read data from the file
   */

  infoList(){
    //List<> list = [];
    while(true){
      //li
    }
    String name = project.name;
  }

  //1- Find the corect local path
  Future<String> get localPath async{
    final path = await getApplicationDocumentsDirectory();
    return path.path;
  }

  // 2- Create a refernce to the file location
  Future<File> get localFile async{
    final file = await localPath;
    //return File("$file/data.txt");
    return File("$file/data.json");
  }


  // 3- Write data to the file
  Future<File> writeData(double value) async{
    final file = await localFile;
    return file.writeAsString('$value');
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
 /* Future<void> save() async {
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
  }*/

  /*downloadFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final taskId = await FlutterDownloader.enqueue(
      url: 'http://myapp/${attach[index]}',
      savedDir: '/sdcard/myapp',
      showNotification: true, // show download progress in status bar (for Android)
      clickToOpenDownloadedFile: true, // click on notification to open downloaded file (for Android)
    );
  }*/

  createDir() async {
    print("----------in createDir----------");
    //Directory? baseDir = await getExternalStorageDirectory(); //only for Android
    String baseDir = (await getApplicationDocumentsDirectory()).path; //works for both iOS and Android
    String dirToBeCreated = "<your_dir_name>";
    String dirToBeCreatede = "storage/emulated/0/<your_dir_name>";
    String finalDir = join(baseDir, dirToBeCreated, dirToBeCreatede);
    var dir = Directory(finalDir);
    bool dirExists = await dir.exists();
    if(!dirExists){
      dir.create(/*recursive=true*/); //pass recursive as true if directory is recursive
    }
    //Now you can use this directory for saving file, etc.
    //In case you are using external storage, make sure you have storage permissions.
  }


}//Fin
