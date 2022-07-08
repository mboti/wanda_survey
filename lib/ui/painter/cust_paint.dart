import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/ui/painter/draw_ruler.dart';
import 'package:matrix_gesture_mb/ui/painter/draw_touch_area.dart';


class CustPaint extends CustomPainter {

  DrawRuler drawRuler = DrawRuler();
  DrawTouchArea drawTouchArea = DrawTouchArea();
  // DrawPt drawPt = DrawPt();
  // DrawAP drawAP = DrawAP();
  // DrawHeatMap drawHeatMap = DrawHeatMap();


  @override
  void paint(Canvas canvas, Size size) {

    drawRuler.paint(canvas, size);
    drawTouchArea.paint(canvas, size);

    /// ce qu'il faudra ajouter
    // drawPt.paint(canvas, size);
    // drawAp.paint(canvas, size);
    // drawHeatMap.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}