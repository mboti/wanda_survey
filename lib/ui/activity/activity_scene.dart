import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix_gesture_mb/api/gest_detector.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/ui/painter/cust_paint.dart';
import 'package:matrix_gesture_mb/utils/screen.dart';

import '../component/component_import_Image.dart';



class ActivityScene extends StatefulWidget {
  const ActivityScene({Key? key}) : super(key: key);

  @override
  State<ActivityScene> createState() => ActivitySceneState();
}



class ActivitySceneState extends State<ActivityScene> {

  late Size imageSize = const Size(0.00, 0.00);
  String pathImage = "images/plan.jpg";

  final GlobalKey _key = GlobalKey();
  final GlobalKey globalKey = GlobalKey();
  double? _x, _y;

  File? imageFile;
  XFile? picture;


  // late double width = WidgetsBinding.instance.window.physicalSize.width;     //Largeur ecran
  // late double height = WidgetsBinding.instance.window.physicalSize.height; //Hauteur écran

  @override
  Widget build(BuildContext context) {

    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    var size = MediaQuery.of(context).size; // get size screen
    //var platform = Theme.of(context).platform; // get type OS
    bool isTablet = Screen.diagonalInches(context) >= 7;

    initProject("name project test", size, isTablet);

    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          //title: const Text('Name project'),
          title: Text(Project().name),
        ),
        body:SizedBox(
          height: size.height,
          width: size.width,
          child: Column(


              children: <Widget>[

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.all(7),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: _getImageDimension,
                  child: const Text('Get Image Size'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.all(2),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed:() =>
                  buildShowDialogForChoiceCamOrGal(context),
                  //ComponentImportImageState().buildShowDialogForChoiceCamOrGal(ComponentImportImageState().context),
                  child: const Text('Get Image'),
                ),

                Text(
                  //imageSize != null ? 'Image Width : ${imageSize.width.toString()} px' : '',
                  'Image Width : ${imageSize.width.toString()} px',
                  style: const TextStyle(fontSize: 15),
                ),
                Expanded(
                  child: GestDetector(
                    key: _key,
                    onMatrixUpdate: (m, tm, sm, rm) {
                      notifier.value = m;
                      // var matrix = GestDetector.compose(m, tm, sm, null);
                      // var angle = GestDetector.decomposeToValues(m).rotation;
                      // print("mounir_____ ${notifier.value}");
                      // print("mounir++++++ ${matrix.toString()}");
                      // print("mounir+++angle+++ ${angle.toString()}");
                    },
                    shouldTranslate: true, /*pas réellement besoin de l'indiquer*/
                    shouldScale: true,     /*pas réellement besoin de l'indiquer*/
                    shouldRotate: false,

                    //onTapDown: (details) {print("onTapDown---${details.globalPosition}---${details.localPosition}");},
                    //shouldScale: false,
                    child: AnimatedBuilder(
                      animation: notifier,
                      builder: (ctx, child) {
                        return Transform(
                          transform: notifier.value,
                          child: Stack(
                            //child: InteractiveViewer(
                            children: <Widget>[


                              Container(
                                //color: Colors.white30,
                                color: Colors.white,


                                child: Center(
                                    child:
                                    buildImageDisplayWidget(),
                                  //ComponentImportImageState().buildImageDisplayWidget(),
                                  /*Image.asset(
                                      pathImage,
                                      fit: BoxFit.cover,
                                      // height: size.height,
                                      // width: size.width,
                                    ),*/
                                  //),
                                ),
                              ),

                              Container(
                                // decoration: const FlutterLogoDecoration(),
                                // padding: const EdgeInsets.all(0),
                                // alignment: const Alignment(0, 0),

                                child: CustomPaint(
                                  //size: Size(size.width * 0.5, size.height * 0.1),
                                  size: const Size(0, 0),
                                  painter: CustPaint(),
                                ),
                              ),


                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ]
          ),
        )
    );
  }


  void _getImageDimension() {
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

    _getImagePosition(_key);
  }

  void _getImagePosition(GlobalKey key) {
    RenderBox? box = _key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    Rect? maBoite = box?.paintBounds;
    if (position != null) {
      setState(() {
        _x = position.dx;
        _y = position.dy;
        print("x: ${_x}      -  Y: ${_y}");
        print(maBoite.toString());
      });
    }
  }


  void initProject(String nameProject, Size size, bool isTablet){
    Project().initProject(nameProject, size.width, size.height, isTablet);
  }


////////////////////////////////////////§§§§§§§§§§§§§2222222222222222222222222222222/////////////////////////


/**
   * Methode pour afficher l'image selectionné
   */

   Widget buildImageDisplayWidget(){
    //mainAxisAlignment : MainAxisAlignment.center;
    if(imageFile != null){ // Selection de notre image
      return  Container(

          child: buildImage()
      );
    }else{
      return Container(
        //width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        //margin: EdgeInsets.all(1.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
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



/**
   * Methode permettant dafficher l'image à selectionner camera/galerie
   * permet de réaliser le zoom
   */

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




