import 'package:matrix_gesture_mb/model/network.dart';

/// Classe décrivant les points de Mesure placés sur un plan

class Pt{

  int? _id;
  String? _label;
  double? _posX;
  double? _posY;
  double _radius = 40.0;
  int? _timestamp;

  List<Network> _networks = <Network>[];

  Pt(this._id, this._label, this._posX, this._posY, this._radius);
  Pt.WithPositionOnly(this._posX, this._posY);
  Pt.WithoutId(this._label, this._posX, this._posY, this._radius);

  int get id => _id!;

  set id(int value) {
    _id = value;
  }

  double get radius => _radius;

  set radius(double value) {
    _radius = value;
  }

  double get posY => _posY!;

  set posY(double value) {
    _posY = value;
  }

  double get posX => _posX!;

  set posX(double value) {
    _posX = value;
  }

  String get label => _label!;

  set label(String value) {
    _label = value;
  }

  int get timestamp => _timestamp!;

  set timestamp(int value) {
    _timestamp = value;
  }

  int getTimestamp(){
    return DateTime.now().millisecondsSinceEpoch;
  }
  /// Setter et update le pt
  updatePt(double x, double y) {
    posX = x;
    posY = y;
  }

  @override
  String toString() {
    return 'Pt{_id: $_id, _label: $_label, _posX: $_posX, _posY: $_posY, _radius: $_radius}';
  }

  /// get la liste de network
  List<Network> get networks {
    return _networks;
  }

  /// Set la liste de Network
  set networks(List<Network> networks) {
    _networks = networks;
  }

  addNetworks (){

  }

  removeNetworks(){

  }

}//Fin