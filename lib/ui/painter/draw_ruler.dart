import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/model/ruler.dart';
import 'package:matrix_gesture_mb/model/touch_area.dart';


class DrawRuler {

  paint(Canvas canvas, Size size) {

    TouchArea? ta = Project().touchArea;

    //info ruler
    Ruler ruler = Project().floors[0].ruler; // TODO à modifier plus tard lorsque j'aurais plusieurs étages
    double mk = ruler.widthMarker;


    // règle
    Paint paintRuler = Paint();
    paintRuler.color = const Color.fromARGB(255, 226, 19, 64);
    paintRuler.strokeWidth = 5/ta!.zoom;
    paintRuler.strokeCap = StrokeCap.round;
    paintRuler.style = PaintingStyle.stroke;
    canvas.drawLine(Offset(ruler.georefX, ruler.georefY), Offset(ruler.scaleX, ruler.scaleY), paintRuler);

    // marker georef
    Paint paintMarker = Paint();
    paintMarker.color = const Color.fromARGB(255, 226, 19, 64);
    paintMarker.strokeWidth = 2/ta.zoom;
    paintMarker.strokeCap = StrokeCap.round;
    paintMarker.style = PaintingStyle.stroke;
    canvas.drawLine(Offset(ruler.georefX-mk, ruler.georefY), Offset(ruler.georefX+mk, ruler.georefY), paintMarker);
    canvas.drawLine(Offset(ruler.georefX, ruler.georefY-mk), Offset(ruler.georefX, ruler.georefY+mk), paintMarker);
    canvas.drawCircle(Offset(ruler.georefX, ruler.georefY), mk/(ta.zoom*4), paintMarker);

    // marker scale
    canvas.drawLine(Offset(ruler.scaleX-mk, ruler.scaleY), Offset(ruler.scaleX+mk, ruler.scaleY), paintMarker);
    canvas.drawLine(Offset(ruler.scaleX, ruler.scaleY-mk), Offset(ruler.scaleX, ruler.scaleY+mk), paintMarker);

    // rectangle en-dessous du texte
    Paint paintBackgroundText = Paint();
    paintBackgroundText.color = const Color.fromRGBO(255,255,255, 0.8);
    paintBackgroundText.strokeWidth = 10.0;
    paintBackgroundText.style = PaintingStyle.fill;
    Size rectSize = Size(mk/(ta.zoom), mk/(ta.zoom*2));

    // texte distance
    TextSpan span = TextSpan(style: TextStyle(color: Colors.red[800], fontSize: 24/ta.zoom), text: ruler.lengthMeter.toString());
    TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    tp.layout();
    canvas.drawRect(Offset(ruler.txtX, ruler.txtY) & rectSize, paintBackgroundText);
    //canvas.drawCircle(Offset(ruler.txtX, ruler.txtY), mk/(ta!.zoom*2), paintBackgroundText);
    tp.paint(canvas, Offset(ruler.txtX, ruler.txtY));
  }

}