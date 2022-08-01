import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/model/network.dart';
import 'package:json_annotation/json_annotation.dart';

/// Classe décrivant les points de Mesure placés sur un plan

part 'pt.g.dart';

@JsonSerializable(explicitToJson: true)
class Pt{

  @JsonKey(name: '_id')
  int? _id ;


  int get id => _id!;

  set id(int value) {
    _id = value;
  }

  String? _label;
  double? _posX;
  double? _posY;
  double _radius = 40.0;
  int? _timestamp;

  List<Network> _networks = <Network>[];

  Pt(int id, String label, double posX, double posY, double radius) {
    _id = id;
    _label = label;
    _posX = posX;
    _posY = posY;
    _radius = radius;
  }
  Pt.WithPositionOnly(this._posX, this._posY);
  Pt.WithoutId(this._label, this._posX, this._posY, this._radius);



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
    return 'Pt{_id: $id, _label: $_label, _posX: $_posX, _posY: $_posY, _radius: $_radius}';
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

  factory Pt.fromJson(Map<String, dynamic> json) => _$PtFromJson(json);


  Map<String, dynamic> toJson() => _$PtToJson(this);


}//Fin