import 'dart:io';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/api/gest_detector.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/ui/component/component_import_Image.dart';
import 'package:matrix_gesture_mb/ui/painter/cust_paint.dart';
import 'package:matrix_gesture_mb/utils/screen.dart';
import 'package:image_picker/image_picker.dart';




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

  double? _x, _y;

  File? imageFile;
  XFile? picture;

  ComponentImportImage componentImportImage = ComponentImportImage();

  /// Fermer de rafraîchir la scène lorsque l'on déplace la règle par exemple
  static final repaintNotifier = ValueNotifier<int>(0);

  //static CustPaint custPaint = CustPaint(repaint: _counter);



  // late double width = WidgetsBinding.instance.window.physicalSize.width;     //Largeur ecran
  // late double height = WidgetsBinding.instance.window.physicalSize.height; //Hauteur écran

  @override
  Widget build(BuildContext context) {

    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    var size = MediaQuery.of(context).size; // get size screen
    //var platform = Theme.of(context).platform; // get type OS
    bool isTablet = Screen.diagonalInches(context) >= 7;

    initProject("name project test", size, isTablet);

    //String pathImage = "images/plan.jpg";
    Project().getFloor(0)!.plan.pathImg = "images/plan.jpg";
    //String? pathImg = Project().getFloor(0)!.plan.pathImg;

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
                  onPressed:() => componentImportImage.createState().buildShowDialogForChoiceCamOrGal(context),
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
                                  child: componentImportImage.createState().buildImageDisplayWidget(),
                                  /*
                                    child: Image.asset(
                                      pathImg!,
                                      fit: BoxFit.cover,
                                      // height: size.height,
                                      // width: size.width,
                                    ),
                                  //),
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

    print("je suis bien passé par là");

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


  void initProject(String nameProject, Size size, bool isTablet){
    Project().initProject(nameProject, size.width, size.height, isTablet);
  }

  refresh() {
    setState(() {});
    print(Project().getFloor(0)?.plan.pathImg);
  }
}




