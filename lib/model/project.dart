import 'dart:convert';

import 'package:matrix_gesture_mb/model/floor.dart';
import 'package:matrix_gesture_mb/model/ruler.dart';
import 'package:matrix_gesture_mb/model/touch_area.dart';

import 'package:json_annotation/json_annotation.dart';


part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {

  /// Création du project en variable statique,
  /// Appel du project:    Project().get.., Project().set.., Project().add..
  static Project? _instance;
  factory Project() => _instance ??= Project._();
  Project._();
  ///------------------------------------------

  /// attributs
  /// ---------
  static bool bDebugMode = true;
  static ItemSelected itemSelected = ItemSelected.none; //aucun élément de selectionné par défaut
  int _idProject = 1;
  String _name = "";
  double _H_screen = 0;
  double _W_screen = 0;
  double _heightFloor = 3;
  bool _isTablet = false;
  String _nameDefaultPlan = "images/ico_soft.png";

  List<Floor> _floors = <Floor>[];
  TouchArea? touchArea;


initProject(String name,double W_screen, double H_screen, bool isTablet){
    _name = name;
    _W_screen = W_screen;
    _H_screen = H_screen;
    _isTablet = isTablet;
    addFloor();
    getFloor(0)!.plan.pathImg = _nameDefaultPlan;
    touchArea = TouchArea.WithParam(1, _isTablet);
  }


  /// setters & getters
  /// -----------------
  int get idProject => _idProject;

  set idProject(int value) {
    _idProject = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get isTablet => _isTablet;

  set isTablet(bool value) {
    _isTablet = value;
  }

  double get heightFloor => _heightFloor;

  set heightFloor(double value) {
    _heightFloor = value;
  }

  List<Floor> get floors => _floors;

  set floors(List<Floor> value) {
    _floors = value;
  }

  double get W_screen => _W_screen;

  set W_screen(double value) {
    _W_screen = value;
  }

  double get H_screen => _H_screen;

  set H_screen(double value) {
    _H_screen = value;
  }


  String get nameDefaultPlan => _nameDefaultPlan;

  set nameDefaultPlan(String value) {
    _nameDefaultPlan = value;
  }

  /// méthodes
  /// --------
  setUpdateSizeScreen(double hScreen, double wScreen){
    H_screen = hScreen;
    W_screen = wScreen;
  }

  addFloor(){
    int nbFloors = _floors.length;  // on récupère le nombre d'étage existant
    double altitude = nbFloors * _heightFloor;
    Floor floor = Floor.WithParam(
                          (nbFloors+1).toString(),
                          altitude,
                          _heightFloor
                        );
    _floors.add(floor);
  }

  removeFloor(){
    //TODO à faire pour plus tard
  }

  Floor? getFloor(int level){
    if(_floors.length>level){
      return _floors[level];
    }
    return null;
  }

  ///==================================================================================================
  ///    PARTIE DEDIEE A LA SERIALISATION/DESERIALISATION JSON
  ///==================================================================================================

  //Permet de convertir notre classe projet en JSON pour pouvoir l'envoyer à notre base de donnée
/*
  Map<String,dynamic> toJson(){
    var map = Map<String,dynamic>();
    map["name"] = _name;
    map["heightFloor"]= _heightFloor;
    map["nameDefaultPlan"]= _nameDefaultPlan;
    map["floors"]= _floors;
    map["idFloor"]= _floors.iterator.current.idFloor;
    map["nameFloor"]= _floors.iterator.current.nameFloor;
    map["altitudeFloor"]= _floors.iterator.current.altitudeFloor;
    map["hauteurFloor"]= _floors.iterator.current.hauteurFloor;
    if(_idProject! == null){
      map["id"]=_idProject;
    }
    return map;
  }

  //Converti notre map en la classe Project pour poivoir recuperer les elm depuis notre map
  Project.fromJson(Map<String, dynamic> json){
    //this.id = int.tryParse(o["id"]);
    this._idProject = json["id"];
    this.name= json["name"];
    this._heightFloor= json["heightFloor"];
    this._nameDefaultPlan =  json["nameDefaultPlan"];
    this._floors =  json["floors"];
    this._floors.iterator.current.idFloor =  json["idFloor"];
    this._floors.iterator.current.nameFloor =  json["nameFloor"];
    this._floors.iterator.current.altitudeFloor =  json["altitudeFloor"];
    this._floors.iterator.current.hauteurFloor =  json["hauteurFloor"];
  }
*/

  factory Project.fromJson(Map<String, dynamic> json) {
    return _$ProjectFromJson(json);
  }


  Map<String, dynamic> toJson() {
    return _$ProjectToJson(this);
  }

  @override
  String toString() {
    return 'Project{_idProject: $_idProject, _name: $_name, _heightFloor: $_heightFloor, _isTablet: $_isTablet, _nameDefaultPlan: $_nameDefaultPlan, _floors: $_floors, touchArea: $touchArea}';
  }




  //final json = Project().toJson();
  //print(Project().)




//Map projetMap = jsonDecode(jsonString);
  //var event = Project().fromJson(projetMap);
  //String json = jsonEncode(event);



}

enum ItemSelected {
  none,
  ptRef,
  ptScale,
  lengthRuler,
  ptMeasure,
  ap
}