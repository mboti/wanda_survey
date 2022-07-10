import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/api/gest_detector.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/ui/painter/cust_paint.dart';
import 'package:matrix_gesture_mb/utils/screen.dart';



class ActivityScene extends StatefulWidget {
  const ActivityScene({Key? key}) : super(key: key);

  @override
  State<ActivityScene> createState() => ActivitySceneState();
}



class ActivitySceneState extends State<ActivityScene> {

  late Size imageSize = const Size(0.00, 0.00);
  String pathImage = "images/plan.jpg";

  final GlobalKey _key = GlobalKey();
  double? _x, _y;

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
                                  //child: InteractiveViewer(

                                    child: Image.asset(
                                      pathImage,
                                      fit: BoxFit.cover,
                                      // height: size.height,
                                      // width: size.width,
                                    ),
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
        if(Project.bDebugMode) { print("x: ${_x}      -  Y: ${_y}");}
        if(Project.bDebugMode) { print(maBoite.toString());}
      });
    }
  }


  void initProject(String nameProject, Size size, bool isTablet){
    Project().initProject(nameProject, size.width, size.height, isTablet);
  }
}




