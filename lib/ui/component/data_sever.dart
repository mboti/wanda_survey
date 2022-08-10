import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:matrix_gesture_mb/model/floor.dart';
import 'package:matrix_gesture_mb/model/plan.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/model/pt.dart';
import 'package:matrix_gesture_mb/model/ruler.dart';
import 'package:matrix_gesture_mb/model/touch_area.dart';
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

   return file.writeAsString(displayTojson());
    //return file.writeAsString('$json2.');
  }

  // 4- Read data from the file
  Future<double> readData() async{
    try{
      final file = await localFile;
      String data = await file.readAsString();
      print("Affichage du date (read)");
      print(data);
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

    Map <String, dynamic> p = json2;

    var kProjectName;
    var valProjectName;

    var valHeightFloor ;

    var valNameDefaultPlan ;

    MapEntry <String, dynamic> kFloorGrowableList ;

    var valFloorGrowableList = [];
    var valFloorid, valFloorName, valFloorAltitude, valFloorHauteur ;
    Floor floor = Floor();

    Plan plan = Plan();
    var valPlanId, valPlanPathImg, valPlanXMin, valPlanYMin, valPlanXMax,
        valPlanYMax, valPlanWidth, valPlanHeigth;

    Ruler ruler = Ruler();
    var valRulerTX, valRulerTY;

    var pts = [];

    var valIsDrawRuler, valIsDrawPt;

    TouchArea touchArea = TouchArea();
    var  valTouchAreaZoom, valTouchAreaZoomMax, valTouchAreaZoomMin,
         valTouchAreaRateAreaTouchVsWMobile, valTouchAreaRateAreaTouchVsWTablet,
         valTouchAreaRateAreaTouchVsW, valTouchAreaXMinTouch, valTouchAreaYMinTouch,
         valTouchAreaXMaxTouch, valTouchAreaYMaxTouch;


    newObj() => p.entries.map((elm) { return elm ; }).toList();


        print("in diplayToJson");


        kProjectName = newObj()[2].key;
        valProjectName = newObj()[2].value;

        valHeightFloor = newObj()[4].value;

        valNameDefaultPlan = newObj()[8].value;

        if(kProjectName != null){
          //Floor
          valFloorGrowableList = newObj()[5].value;
          // TODO MBO
          for(int i = 0; i<valFloorGrowableList.length; i++){
            if(valFloorGrowableList.isNotEmpty){
              floor = valFloorGrowableList.elementAt(i);
              valFloorid = floor.idFloor;
              valFloorName = floor.nameFloor;
              valFloorAltitude = floor.altitudeFloor;
              valFloorHauteur = floor.hauteurFloor;

              valIsDrawRuler = floor.isDrawRuler;
              valIsDrawPt = floor.isDrawPt;

              if(valFloorid != null){
                //Paln
                plan = floor.plan;
                plan.runtimeType.toString();
                valPlanId = plan.idPlan;
                valPlanPathImg = plan.pathImg;
                valPlanXMin = plan.xMin;
                valPlanYMin = plan.yMin;
                valPlanXMax = plan.xMax;
                valPlanYMax = plan.yMax;
                valPlanWidth = plan.width;
                valPlanHeigth = plan.height;

                // Ruler
                ruler = floor.ruler;
                valRulerTX = ruler.txtX;
                valRulerTY = ruler.txtY;

                //Pt
                pts = floor.pts;


              }
            }
          }

          //touchArea = newObj()[0].value;
          touchArea =  project.touchArea!; // Make Sure, it is a project same Object  !!!

          valTouchAreaZoom = touchArea.zoom;
          valTouchAreaZoomMin = touchArea.zoomMin;
          valTouchAreaZoomMax = touchArea.zoomMax;
          valTouchAreaRateAreaTouchVsWMobile = touchArea.rateAreaTouchVsWMobile;
          valTouchAreaRateAreaTouchVsWTablet = touchArea.rateAreaTouchVsWTablet;
          //valTouchAreaRateAreaTouchVsW
          valTouchAreaXMinTouch = touchArea.xMinTouch;
          valTouchAreaYMinTouch = touchArea.yMinTouch;
          valTouchAreaXMaxTouch = touchArea.xMaxTouch;
          valTouchAreaYMaxTouch = touchArea.yMaxTouch;


        }


    return [
      ('valProjectKey: $kProjectName, valProjectName: $valProjectName'),
      ('ValvalHeightFloor: $valHeightFloor'),
      ('ValNameDefaultPlan: $valNameDefaultPlan'),
      ('FloorGrowableList: $valFloorGrowableList'),
      ('ValueIdF: $valFloorid, ValueName: $valFloorName, ValueAltitude: $valFloorAltitude, Valuehauteur: $valFloorHauteur '),
      ('ValueIdP: $valPlanId, ValuePathImg: $valPlanPathImg, ValuePlanXMin: $valPlanXMin, ValuePlanYMin: $valPlanYMin, ValuePlanXMax: $valPlanXMax, ValuePlanYMax: $valPlanYMax, ValuePlanWidth: $valPlanWidth, ValuePlanHeigth: $valPlanHeigth '),
      ('valRulerTxtX: $valRulerTX,  valRulerTxtY: $valRulerTY'),
      ('valPts: $pts'),
      ('valIsDrawRuler: $valIsDrawRuler,  valIsDrawPt: $valIsDrawPt'),
      ('zoom: $valTouchAreaZoom, zoomMin: $valTouchAreaZoomMin, zoomMax: $valTouchAreaZoomMax,  '
          'RateAreaTouchVsWMobile: $valTouchAreaRateAreaTouchVsWMobile, RateAreaTouchVsWTablet: $valTouchAreaRateAreaTouchVsWTablet,'
          'xMinTouch: $valTouchAreaXMinTouch, yMinTouch: $valTouchAreaYMinTouch, '
          'xMaxTouch: $valTouchAreaXMaxTouch, yMaxTouch: $valTouchAreaYMaxTouch'),

    ].toString();

  }

  final newProject = Project.fromJson(json);
  displayFromJson(){
    print('ProjectJson, meth fromJson: $newProject');
    print("//////---- display of d2---///////");
    readJsonData();
  }


  Future<String> readJsonData() async{
    final jsonData = await rootBundle.loadString('doc/d2.json');
    try{
      Map<String, dynamic> myJson = jsonDecode(jsonData.toString());
      print(myJson.toString());
    }catch(e){
      print(e);
    }
    return " ";
  }

 



  ///===================================================
  /// Enregistrer suivant les contraintes du projet
  ///===================================================


////////////////////////////////////// TESST  1  1 2 1 2 1 2 1 2 1 2//////////////////////

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

  displayFromJsonFile(){
    readData().runtimeType;
  }

}//Fin
