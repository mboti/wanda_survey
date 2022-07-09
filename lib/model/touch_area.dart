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

  double _zoom=1;
  double _rateAreaTouchVsW=0.1;
  double _Xmin_touch=0;
  double _Ymin_touch=0;
  double _Xmax_touch=0;
  double _Ymax_touch=0;

  TouchArea(double zoom, bool isTablet){
    _zoom = zoom;

    // Mobile -> rateAreaTouchVsW = 0.2
    // Tablet -> rateAreaTouchVsW = 0.1
    _rateAreaTouchVsW = (isTablet) ? 0.1 : 0.2;
  }


  UpdateArea(double xTouch, double yTouch){
    double Wa = _rateAreaTouchVsW * Project().W_screen / _zoom;
    _Xmin_touch  = (xTouch - (Wa/2));
    _Ymin_touch  = (yTouch - (Wa/2));
    _Xmax_touch  = (xTouch + (Wa/2));
    _Ymax_touch  = (yTouch + (Wa/2));
  }

  double get Ymax_touch => _Ymax_touch;

  double get Xmax_touch => _Xmax_touch;

  double get Ymin_touch => _Ymin_touch;

  double get Xmin_touch => _Xmin_touch;

  double get zoom => _zoom;

  set zoom(double value) {
    _zoom = value;
  }

  @override
  String toString() {
    return "Zoom: ${_zoom}  Xmin: ${_Xmin_touch}  Ymin: ${_Ymin_touch}  Xmax: ${_Xmax_touch}  Ymax: ${_Ymax_touch}";
  }


  // Va comparer la position de mon doigt avec l'objet sur mon écran
  bool isFingerOverObject(double PtObjX, double PtObjY){
    if( _Xmax_touch > PtObjX &&
        _Xmin_touch < PtObjX &&
        _Ymax_touch > PtObjY &&
        _Ymin_touch < PtObjY){
      return true;
    }
    return false;
  }

}
