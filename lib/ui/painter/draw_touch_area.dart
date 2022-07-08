import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/model/touch_area.dart';



class DrawTouchArea {

  paint(Canvas canvas, Size size) {

    TouchArea? ta = Project().touchArea;

    Color rectColor = const Color(0xff14539c);
    double w = ta!.Xmax_touch - ta.Xmin_touch;
    double h = ta.Ymax_touch - ta.Ymin_touch;

    Size rectSize = Size(w, h);
    var paint1 = Paint()
      ..color = rectColor
      ..style = PaintingStyle.stroke
    ..strokeWidth = 4/ta.zoom;
    canvas.drawRect(Offset(ta.Xmin_touch, ta.Ymin_touch) & rectSize, paint1);
  }

}