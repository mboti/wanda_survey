import 'package:matrix_gesture_mb/model/floor.dart';
import 'package:matrix_gesture_mb/model/touch_area.dart';



class Project {

  /// Création du project en variable statique,
  /// Appel du project:    Project().get.., Project().set.., Project().add..
  static Project? _instance;
  factory Project() => _instance ??= Project._();
  Project._();
  ///------------------------------------------

  /// attributs
  /// ---------
  static bool bDebugMode = false;
  int _idProject = 1;
  String _name = "";
  double _H_screen = 0;
  double _W_screen = 0;
  double _heightFloor = 3;
  bool _isTablet = false;

  List<Floor> _floors = <Floor>[];
  TouchArea? touchArea;

  initProject(String name,double W_screen, double H_screen, bool isTablet){
    _name = name;
    _W_screen = W_screen;
    _H_screen = H_screen;
    _isTablet = isTablet;
    addFloor();
    touchArea = TouchArea(1, _isTablet);
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

  /// méthodes
  /// --------
  setUpdateSizeScreen(double hScreen, double wScreen){
    H_screen = hScreen;
    W_screen = wScreen;
  }

  addFloor(){
    int nbFloors = _floors.length;  // on récupère le nombre d'étage existant
    double altitude = nbFloors * _heightFloor;
    Floor floor = Floor(
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
}


/*
  int? id;
  String? name;
  String? description;
  String? image;

  Project({this.name, this.description, this.image});
  Project.withId({this.id, this.name, this.description, this.image});
  Project.withNameAndDescription({this.name, this.description});

  /**
   * Permet de convertir notre classe projet en Map pour
   * pouvoir l'envoyer à notre base de donnée
   */
  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["name"]=name;
    map["description"]=description;
    map["image"]=image;
    if(id!=null){
      map["id"]=id;
    }
    return map;
  }

  /**
   * Converti notre map en la classe Project pour poivoir
   * recuperer les elm depuis notre map
   */
  Project.fromObject(dynamic o){
    //this.id = int.tryParse(o["id"]);
    this.id = o["id"];
    this.name=o["name"];
    this.description=o["description"];
    this.image = o["image"];
  }
*/
