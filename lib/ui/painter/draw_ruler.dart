import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/model/ruler.dart';
import 'package:matrix_gesture_mb/model/touch_area.dart';


class DrawRuler {

  paint(Canvas canvas, Size size) {

    TouchArea? ta = Project().touchArea;

    Paint paintRuler = Paint();
    paintRuler.color = const Color.fromARGB(255, 226, 19, 64);
    paintRuler.strokeWidth = 5/ta!.zoom;
    paintRuler.strokeCap = StrokeCap.round;

    Paint paintMarker = Paint();
    paintMarker.color = const Color.fromARGB(255, 0, 0, 0);
    paintMarker.strokeWidth = 1/ta!.zoom;
    paintMarker.strokeCap = StrokeCap.round;

    Ruler ruler = Project().floors[0].ruler; // TODO à modifier plus tard lorsque j'aurais plusieurs étages
    double mk = ruler.widthMarker;


    Offset startingOffset = Offset(ruler.georefX, ruler.georefY);
    Offset endingOffset = Offset(ruler.scaleX, ruler.scaleY);
    canvas.drawLine(startingOffset, endingOffset, paintRuler);

    // marker georef
    canvas.drawLine(Offset(ruler.georefX-mk, ruler.georefY), Offset(ruler.georefX+mk, ruler.georefY), paintMarker);
    canvas.drawLine(Offset(ruler.georefX, ruler.georefY-mk), Offset(ruler.georefX, ruler.georefY+mk), paintMarker);

    // marker scale
    canvas.drawLine(Offset(ruler.scaleX-mk, ruler.scaleY), Offset(ruler.scaleX+mk, ruler.scaleY), paintMarker);
    canvas.drawLine(Offset(ruler.scaleX, ruler.scaleY-mk), Offset(ruler.scaleX, ruler.scaleY+mk), paintMarker);
  }

}