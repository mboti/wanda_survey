import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/model/ruler.dart';
import 'package:matrix_gesture_mb/model/touch_area.dart';


class DrawRuler {

  paint(Canvas canvas, Size size) {

    TouchArea? ta = Project().touchArea;

    Paint paint = Paint();
    paint.color = const Color.fromARGB(255, 226, 19, 64);
    paint.strokeWidth = 5/ta!.zoom;
    paint.strokeCap = StrokeCap.round;

    Ruler ruler = Project().floors[0].ruler; // TODO à modifier plus tard lorsque j'aurais plusieurs étages
    Offset startingOffset = Offset(ruler.georefX, ruler.georefY);
    Offset endingOffset = Offset(ruler.scaleX, ruler.scaleY);

    canvas.drawLine(startingOffset, endingOffset, paint);
  }

}