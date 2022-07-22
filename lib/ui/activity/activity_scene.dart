import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:matrix_gesture_mb/api/gest_detector.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/ui/component/data_sever.dart';
import 'package:matrix_gesture_mb/ui/component/menu_svg.dart';
import 'package:matrix_gesture_mb/ui/painter/cust_paint.dart';
import 'package:matrix_gesture_mb/utils/screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

import 'package:permission_handler/permission_handler.dart';


class ActivityScene extends StatefulWidget {
  const ActivityScene({Key? key}) : super(key: key);

  @override
  State<ActivityScene> createState() => ActivitySceneState();
}



class ActivitySceneState extends State<ActivityScene> {

  late Size imageSize = const Size(0.00, 0.00);
  //String pathImage = "images/plan.jpg";

  final GlobalKey _key = GlobalKey();
  final GlobalKey globalKey = GlobalKey();

  File? imageFile;
  XFile? picture;

  // Le paramètre correspond à la largeur de l'image
  MenuSvg menuSvg = MenuSvg(100);

  DataServer dataServer = DataServer();
  DataServerState dataServerState = DataServerState(); 


  //PartDialogImportPlan componentImportImage = PartDialogImportPlan();

  /// Fermer de rafraîchir la scène lorsque l'on déplace la règle par exemple
  static final repaintNotifier = ValueNotifier<int>(0);




  //static CustPaint custPaint = CustPaint(repaint: _counter);



  // late double width = WidgetsBinding.instance.window.physicalSize.width;     //Largeur ecran
  // late double height = WidgetsBinding.instance.window.physicalSize.height;   //Hauteur écran

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
          title: Text(Project().name),
          centerTitle: true,
          automaticallyImplyLeading: false, //supprime le bouton retour de l'apbar.
          leading: buildBackButtonLeadingField(),
          actions: <Widget>[menuSvg.build_ico_save2Button(), ],
        ),

        body:SizedBox(
          height: size.height,
          width: size.width,
          child: Column(

              children: <Widget>[
                menuSvg.buildRowForButtons(),
                //menuSvg.buildRowForLockUnluckButtons(),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.all(2),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed:() => buildShowDialogForChoiceCamOrGal(),
                  //onPressed:() => buildShowDialogForChoiceCamOrGal(context),
                  child: const Text('Get Image'),
                ),

                Text(
                  //imageSize != null ? 'Image Width : ${imageSize.width.toString()} px' : '',
                  'Image Width : ${imageSize.width.toString()} px',
                  style: const TextStyle(fontSize: 15),
                ),

               /* ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  ),
                  onPressed:() => dataServerState.writeData(199999999),
                  child: const Text('import'),
                ),*/
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  ),
                  onPressed:() {[
                    save(),
                    // dataServerState.save(),
                    dataServerState.createDir(),
                    dataServerState.writeData(199999999.22),
                  ];
                  },
                  child: const Text('save'),
                ),


                Expanded(
                  child: GestDetector(
                    key: _key,
                    // onTapUp: (TapUpDetails details) {
                    //   _counter.value++;
                    // },
                    onMatrixUpdate: (m, tm, sm, rm) {
                      notifier.value = m;
                      // var matrix = GestDetector.compose(m, tm, sm, null);
                      // var angle = GestDetector.decomposeToValues(m).rotation;
                      if(Project.bDebugMode) {  print("mounir_____ ${notifier.value}"); }
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
                                  //child: buildImageDisplayWidget(),
                                  child: buildImageDisplayWidget(),
                                  /*
                                    child: Image.asset(
                                      pathImg!,
                                      fit: BoxFit.cover,
                                    ),
                                  */
                                ),
                              ),

                              Container(
                                // decoration: const FlutterLogoDecoration(),
                                // padding: const EdgeInsets.all(0),
                                // alignment: const Alignment(0, 0),

                                child: CustomPaint(
                                  //size: Size(size.width * 0.5, size.height * 0.1),
                                  size: const Size(0, 0),
                                  painter: CustPaint(repaint: repaintNotifier),//custPaint,
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

  void initProject(String nameProject, Size size, bool isTablet){
    Project().initProject(nameProject, size.width, size.height, isTablet);
  }



  ///===========================================================================
  ///              BOITE DE DIALOGUE POUR IMPORTER UN PLAN
  ///===========================================================================

  Widget buildImageDisplayWidget(){
    //mainAxisAlignment : MainAxisAlignment.center;
    if(imageFile != null){ // Selection de notre image
      return  RepaintBoundary(
          key: globalKey,
          child: buildImage()
      );
    }else{
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Project().nameDefaultPlan),
            ),
            color: Colors.black12
        ),
      );
    }
  }

  _openCamera() async{
    ImagePicker imagePicker = ImagePicker();
    var picture = await imagePicker.pickImage(source: ImageSource.camera);
    if(picture?.path != null){
      setState(() {
        imageFile = File(picture!.path);
        updateProject(picture.path);
      });
    }
    /// Ne stockez pas le contexte directement dans des classes personnalisées et
    /// n'utilisez pas le contexte après asynchrone si vous n'êtes pas sûr que votre widget est monté.
    ///    https://stackoverflow.com/questions/68871880/do-not-use-buildcontexts-across-async-gaps
    Navigator.of(context).pop();
  }



  _openGalery() async{
    ImagePicker imagePicker = ImagePicker();
    var picture = await imagePicker.pickImage(source: ImageSource.gallery);
    if(picture?.path != null){
      setState(() {
        imageFile = File(picture!.path);
        updateProject(picture.path);
      });
    }
    Navigator.of(context).pop();
  }



  // Boîte de dialogue destiné à importer un plan
  Future<void> buildShowDialogForChoiceCamOrGal(){
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
                  _openCamera();
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              ElevatedButton(
                child: const Text("Galerie"),
                onPressed: () {
                  //getImage(imageSource: ImageSource.gallery);
                  _openGalery();
                },
              )
            ],
          ),
        ),
      );
    });
  }




  Widget buildImage () {
    return Container(
      //key: _key,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(imageFile!),
          ),
          color: Colors.black12
      ),
    );
  }

  updateProject(String path) {
    // Indiquer le nouveau chemin de l'image + activer la règle
    Project().getFloor(0)!.plan.pathImg = path;
    Project().getFloor(0)!.isDrawRuler = true;
  }


  ///===========================================================================
  ///                           MANAGE MENU
  ///===========================================================================

  // Bouton pour revenir à la page d'acceuil
  buildBackButtonLeadingField() {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: navigateToHomePage,
    );
  }
  // Bouton pour Enregistrer le projet
  buildSaveButtonField() { //TODO Koudous
    return IconButton(
      icon: Icon(Icons.save),
      onPressed: (){
        [

        ];
      },
    );
  }

  // Methode pour revenir sur la 1ère page Home
  void navigateToHomePage(){
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  ///===========================================================================
  ///    PARTIE DEDIEE A RECUPERER DES INFOS SUR LES DIMENSIONS DE L IMAGE
  ///===========================================================================
  /*
  _getImageDimension() {
    //Image image = Image.network(imageURL);
    //Image image = Image.asset(pathImg);
    Project().getFloor(0)!.plan.pathImg = "images/plan2.jpg";
    String? pathImg = Project().getFloor(0)?.plan.pathImg;
    Image image = Image.asset(pathImg!);
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
    refresh();

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
        if(Project.bDebugMode) { print("x: ${_x}      -  Y: ${_y}");}
        if(Project.bDebugMode) { print(maBoite.toString());}
      });
    }
  }

  refresh() {
    setState(() {});
    print(Project().getFloor(0)?.plan.pathImg);
  }
   */

  ///==================================================================================================
  ///    PARTIE DEDIEE A Enregistrer dans la galerie
  ///==================================================================================================

  // Methode permettant de sauver le custum painter (la scène) dans la galerie
  Future<void> save() async {
    print("in the _save fun");
    RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    setState() {
      pngBytes;
    }


    //Request permissions if not already granted
    //if (!(await Permission.storage.status.isGranted))
    //await Permission.storage.request();

    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(pngBytes),
        quality: 60,
        name: "canvas_image");
    print(result);
  }


}




