import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/model/touch_area.dart';



class DrawTouchArea {

  paint(Canvas canvas, Size size) {

    TouchArea? ta = Project().touchArea;

    //Color rectColor = const Color(0xff14539c);
    //couleur jaune fluo
    Color rectColor = const Color.fromRGBO(255,255, 0, 0.3);
    double w = ta!.xMaxTouch - ta.xMinTouch;
    double h = ta.yMaxTouch - ta.yMinTouch;

    Size rectSize = Size(w, h);
    var paint1 = Paint()
      ..color = rectColor
      ..style = PaintingStyle.fill
    ..strokeWidth = 4/ta.zoom;
    canvas.drawRect(Offset(ta.xMinTouch, ta.yMinTouch) & rectSize, paint1);
  }

}
