

import 'package:matrix_gesture_mb/model/project.dart';

class Ruler{

  late double _georefX;
  late double _georefY;
  late double _scaleX;
  late double _scaleY;
  late double _length;
  double rateRulerVsW = 0.5;


  Ruler(){
    // position de ma règle
    _georefX = ((Project().W_screen/2) - ((Project().W_screen * rateRulerVsW)/2));
    _georefY = Project().H_screen/2;
    _scaleX = ((Project().W_screen/2) + ((Project().W_screen * rateRulerVsW)/2));
    _scaleY = Project().H_screen/2;
    // longueur de ma règle par défaut lors de l'initialisation
    _length = 5.0;
  }


  double get georefX => _georefX;

  set georefX(double value) {
    _georefX = value;
  }

  double get georefY => _georefY;

  double get length => _length;

  set length(double value) {
    _length = value;
  }

  double get scaleY => _scaleY;

  set scaleY(double value) {
    _scaleY = value;
  }

  double get scaleX => _scaleX;

  set scaleX(double value) {
    _scaleX = value;
  }

  set georefY(double value) {
    _georefY = value;
  }


}