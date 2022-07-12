/*
  Mobile -> rateAreaTouchVsW = 0.2
  Tablet -> rateAreaTouchVsW = 0.1

  On réalisera des tests avec ses valeurs et on ajustera par la suite

  Wa = rateAreaTouchVsW * W * scale.
  (scale correspond au zoom ecran)

  Ptouch = (xTouch, yTouch)

  AreaTouch:
  Xmin_touch  = xTouch – (Wa/2)
  Ymin_touch  = yTouch – (Wa/2)
  Xmax_touch = xTouch + (Wa/2)
  Ymax_touch  = yTouch + (Wa/2)
 */
import 'package:matrix_gesture_mb/model/project.dart';



class TouchArea {

  double _zoom = 1;
  final double _zoomMax = 5;
  final double _zoomMin = 0.3;
  final double rateAreaTouchVsWMobile = 0.15;  /// modifier cette valeur pour l'ajuster au mobile
  final double rateAreaTouchVsWTablet = 0.10;  /// modifier cette valeur pour l'ajuster à la tablette
  double _rateAreaTouchVsW = 0.1;
  double _xMinTouch = 0;
  double _yMinTouch = 0;
  double _xMaxTouch = 0;
  double _yMaxTouch = 0;

  TouchArea(double zoom, bool isTablet){
    _zoom = zoom;

    // Mobile -> rateAreaTouchVsW = 0.2
    // Tablet -> rateAreaTouchVsW = 0.1
    _rateAreaTouchVsW = (isTablet) ? rateAreaTouchVsWTablet: rateAreaTouchVsWMobile ;
  }


  updateArea(double xTouch, double yTouch){
    double wa = _rateAreaTouchVsW * Project().W_screen / _zoom;
    _xMinTouch  = (xTouch - (wa/2));
    _yMinTouch  = (yTouch - (wa/2));
    _xMaxTouch  = (xTouch + (wa/2));
    _yMaxTouch  = (yTouch + (wa/2));
  }

  double get yMaxTouch => _yMaxTouch;

  double get xMaxTouch => _xMaxTouch;

  double get yMinTouch => _yMinTouch;

  double get xMinTouch => _xMinTouch;

  double get zoom => _zoom;

  double get zoomMax => _zoomMax;

  double get zoomMin => _zoomMin;

  set zoom(double value) {
    _zoom = value;
  }

  @override
  String toString() {
    return "Zoom: $_zoom  Xmin: $_xMinTouch  Ymin: $_yMinTouch  Xmax: $_xMaxTouch  Ymax: $_yMaxTouch";
  }


  // Va comparer la position de mon doigt avec l'objet sur mon écran
  bool isFingerOverObject(double ptObjX, double ptObjY){
    if( _xMaxTouch > ptObjX &&
        _xMinTouch < ptObjX &&
        _yMaxTouch > ptObjY &&
        _yMinTouch < ptObjY){
      return true;
    }
    return false;
  }
}
