import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix_gesture_mb/model/project.dart';

class ImportPlan extends StatefulWidget {
  const ImportPlan({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw _ImportPlanState();
  }
}

enum ManageImageAction {
  FIG1,
  FIG2,
  FIG3
}

class _ImportPlanState extends State<ImportPlan>{

  GlobalKey globalKey = GlobalKey();
  File? imageFile;
  late Size imageSize = const Size(0.00, 0.00);
  String pathImage = "images/plan.jpg";
  double? _x, _y;


  //late double? widths = MediaQueryData.fromWindow(WidgetsBinding.instance.window) as double?;   //larg ecran
  late double? widths = WidgetsBinding.instance.window.physicalSize.width;  //larg ecran
  late double? heigths =  WidgetsBinding.instance.window.physicalSize.height;  //haut ecran
  late double? rateHWs = widths!/heigths!;      //taux WT ecran


  late Size size = _getImageDimension();
  late double? widthi = size.width;   //larg img
  late double? heigthi = size.height;  //haut image
  late double? rateHWi = widthi!/heigthi!;      //taux WT img


  @override
  Widget build(BuildContext context) {

    return const Scaffold(
    );
  }

  Size _getImageDimension() {
    //Image image = Image.network(imageURL);
    Image image = Image.asset(pathImage);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          setState(() {
            imageSize = Size(myImage.width.toDouble(), myImage.height.toDouble());
          });
        },
      ),
    );

    _getImagePosition(globalKey);
    return imageSize;
  }

  void _getImagePosition(GlobalKey key) {
    RenderBox? box = globalKey.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    Rect? maBoite = box?.paintBounds;
    if (position != null) {
      setState(() {
        _x = position.dx;
        _y = position.dy;
        if(Project.bDebugMode) { print("x: ${_x}      -  Y: ${_y}");}
        if(Project.bDebugMode) { print(maBoite.toString());}
      });
    }
  }

  /**
   *
   * @param rateWHs
   * @param rateWHi
   * @return
   */
  compare(double rateWHs, double rateWHi) {
    if (rateWHs > rateWHi) {
      return ManageImageAction.FIG1;
    } else if (rateWHs < rateWHi) {
      return ManageImageAction.FIG2;
    } else {
      return ManageImageAction.FIG3;
    }
  }

  displayImageOnTheTelCorrectly(){

    switch(compare(this.rateHWs!, this.rateHWi!)) {
      case "FG1":
        print('cas 1 !');
        double? hScreen = heigths;
        double? hImg = hScreen;
        double? v = ((this.widthi!*this.heigths!)/this.heigthi!);
        double? wImg = v;
        double? xMin = ((wImg/2) - (v/2));
        double? yMin = 0.0;
        double? xMax = ((wImg/2) + (v/2));
        double? yMax = hImg;
        // Traitement de la scène et de l'image
        break;
      case "FG2":
        print('cas 2!');
        double? wScreen = widths;
        double? wImg = wScreen;
        double? v = ((this.widths!*this.heigthi!)/(this.heigths!*this.widthi!));
        double? hImg = v;
        double? xMin = 0.0;
        double? yMin = ((this.heigths!/2) - (v/2));
        double? xMax = wScreen;
        double? yMax = ((this.heigths!/2) + (v/2));
        //Traitement scene et image cas de fig2
        break;
      default:
        print('cas 3');
        double? hScreen = heigths;
        double? wScreen = widths;
        double? hImg = hScreen;
        double? wImg = wScreen;
        double? xMin = 0.0;
        double? yMin = 0.0;
        double? xMax = wScreen;
        double? yMax = hScreen;
        //Traitement scene et image cas de fig3
    }
  }

  /////////////////////////////*************////////////////////////////////////

  /**
   * Methode pour acceder à la camera
   */
  _openCamera(BuildContext context) async{
    ImagePicker imagePicker = ImagePicker();
    var picture = await imagePicker.pickImage(source: ImageSource.camera);
    if(picture?.path != null){
      this.setState(() {
        imageFile = File(picture!.path);
      });
    }
    Navigator.of(context).pop();
  }

  /**
   * Methode pour acceder à la galerie
   */
  _openGalery(BuildContext context) async{
    ImagePicker imagePicker = ImagePicker();
    var picture = await imagePicker.pickImage(source: ImageSource.gallery);
    if(picture?.path != null){
      this.setState(() {
        imageFile = File(picture!.path);
      });
    }
    Navigator.of(context).pop();
  }

  /**
   * Methode affichant la boite de dialoge pour choisir
   * galerie/camera
   */
  Future<void> buildShowDialogForChoiceCamOrGal(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Ouvrir"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  //getImage(imageSource: ImageSource.gallery);
                  _openCamera(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("Galerie"),
                onTap: () {
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





}//Fin