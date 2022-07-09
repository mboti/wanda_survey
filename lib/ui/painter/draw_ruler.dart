import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/model/ruler.dart';


class DrawRuler {

  paint(Canvas canvas, Size size) {

    Paint paint = Paint();
    paint.color = const Color.fromARGB(255, 226, 19, 64);
    paint.strokeWidth = 5;
    paint.strokeCap = StrokeCap.round;

    Ruler ruler = Project().floors[0].ruler; // TODO à modifier plus tard lorsque j'aurais plusieurs étages
    Offset startingOffset = Offset(ruler.georefX, ruler.georefY);
    Offset endingOffset = Offset(ruler.scaleX, ruler.scaleY);

    canvas.drawLine(startingOffset, endingOffset, paint);
  }

}





/*
class CustRuler extends CustomPainter{

  Ruler =

  // Ruler ruler = _project.getfloor.getRuler()

  //Size size = WidgetsBinding.instance.window.physicalSize;
  late double width = WidgetsBinding.instance.window.physicalSize.width;     //Largeur ecran
  late double height = WidgetsBinding.instance.window.physicalSize.height; //Hauteur écran

  late double rateRulerVsW = width/2;

  late double georefX = ((width/2) - ((width*rateRulerVsW)/2));
  late double georefY = height/2;
  late double scaleX = ((width/2) + ((width*rateRulerVsW)/2));
  late double scaleY = height/2;


  late Offset pt1 = Pt.WithOffset(Offset(georefX, georefY)) as Offset;
  late Offset pt2 = Pt.WithOffset(Offset(scaleX, scaleY)) as Offset;

  static const markerRadius = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;


    canvas.drawCircle(pt1, markerRadius, paint);
    canvas.drawCircle(pt2, markerRadius, paint);

    paintLine(canvas, size);
  }

  void paintLine(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.amber
      ..strokeWidth = 14.0;

    /**
     * Traceur de ligne:
     *  -coordonné du point A
     *  -coordonné du point B
     *  -objetPaint qui permet de definir les caracteristique de notre objet à dessiner
     */
    canvas.drawLine(
      //p1, p2, paint
      pt1, // P1
      pt2, // P2
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

  @override
  String toString() {
    return 'Ruler{pt1: $pt1, pt2: $pt2}';
  }


}//Fin

*/




/*
  int? xMinPixImg, yMinPixImg, xMaxPixImg, yMaxPixImg;
  int? distPixImg;
  double? xMinPixScene, yMinPixScene, xMaxPixScene, yMaxPixScene;
  double? distMeter;

  ///
  Ruler(int widthScene, int heightScene){
    distMeter = 10.0;
    double rateHorizRulerVsScene = 0.25;
    //xMinPixScene, yMinPixScene, xMaxPixScene, yMaxPixScene
  }
*/