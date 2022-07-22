import 'package:matrix_gesture_mb/model/plan.dart';
import 'package:matrix_gesture_mb/model/pt.dart';
import 'package:matrix_gesture_mb/model/ruler.dart';

/// On ne s'en occupe pas pour le moment


class Floor{

  int? _idFloor;
  String? _nameFloor;
  double? _altitudeFloor;
  double? _hauteurFloor;

  Plan plan = Plan.WithImageCoordinate(0.0, 0.0);
  late Ruler ruler;
  List<Pt> _pts = <Pt>[];

  late bool _isDrawRuler;
  late bool _isDrawPt;

  //Pt pt = Pt.WithOffset(Offset.zero);
  Floor(String nameFloor, double altitudeFloor, double hauteurFloor){
    _idFloor = 1;
    _nameFloor = nameFloor;
    _altitudeFloor = altitudeFloor;
    _hauteurFloor = hauteurFloor;
    ruler = Ruler();
    _isDrawRuler = false;
    _isDrawPt = true;
  }




  int get idFloor => _idFloor!;

  set idFloor(int value) {
    _idFloor = value;
  }

  List<Pt> get pts => _pts;

  set pts(List<Pt> value) {
    _pts = value;
  }

  double get hauteurFloor => _hauteurFloor!;

  set hauteurFloor(double value) {
    _hauteurFloor = value;
  }

  double get altitudeFloor => _altitudeFloor!;

  set altitudeFloor(double value) {
    _altitudeFloor = value;
  }

  String get nameFloor => _nameFloor!;

  set nameFloor(String value) {
    _nameFloor = value;
  }

  bool get isDrawRuler => _isDrawRuler;

  set isDrawRuler(bool value) {
    _isDrawRuler = value;
  }

  bool get isDrawPt => _isDrawPt;

  set isDrawPt(bool value) {
    _isDrawPt = value;
  }

  addPt (){
  }

  removePt(){
  }


}//Fin