import 'package:matrix_gesture_mb/model/project.dart';

class Ruler{

  late double _georefX;
  late double _georefY;
  late double _scaleX;
  late double _scaleY;
  late double _lengthMeter;
  //late int _lengthPixel;
  double rateRulerVsW = 0.5;
  late double _widthMarker;



  Ruler(){
    // position de ma règle
    _georefX = ((Project().W_screen/2) - ((Project().W_screen * rateRulerVsW)/2));
    _georefY = Project().H_screen/2;
    _scaleX = ((Project().W_screen/2) + ((Project().W_screen * rateRulerVsW)/2));
    _scaleY = Project().H_screen/2;

    //largeur marker
    _widthMarker = Project().W_screen *0.1;
    // longueur de ma règle par défaut lors de l'initialisation
    _lengthMeter = 5.0;
  }


  double get georefX => _georefX;
  set georefX(double value) {
    _georefX = value;
  }

  double get georefY => _georefY;
  set georefY(double value) {
    _georefY = value;
  }

  double get scaleX => _scaleX;
  set scaleX(double value) {
    _scaleX = value;
  }

  double get scaleY => _scaleY;
  set scaleY(double value) {
    _scaleY = value;
  }

  double get lengthMeter => _lengthMeter;
  set lengthMeter(double value) {
    _lengthMeter = value;
  }

  double get widthMarker => _widthMarker;
}