import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/ui/painter/draw_ruler.dart';
import 'package:matrix_gesture_mb/ui/painter/draw_touch_area.dart';


class CustPaint extends CustomPainter {

  /// Un listener pour Rafraîchir La scene lorsque je déplace par exemple le ruler
  CustPaint({required Listenable repaint}) : super(repaint: repaint) {}

  DrawRuler drawRuler = DrawRuler();
  DrawTouchArea drawTouchArea = DrawTouchArea();
  //DrawPlan drawPlan = DrawPlan();
  // DrawPt drawPt = DrawPt();
  // DrawAP drawAP = DrawAP();
  // DrawHeatMap drawHeatMap = DrawHeatMap();


  @override
  void paint(Canvas canvas, Size size) {

    if(Project().getFloor(0)!.isDrawRuler){
      drawRuler.paint(canvas, size);
    }
    drawTouchArea.paint(canvas, size);

    /// ce qu'il faudra ajouter
    // drawPt.paint(canvas, size);
    // drawAp.paint(canvas, size);
    // drawHeatMap.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}