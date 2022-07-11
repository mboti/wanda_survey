

/// ssid  =>  LIVEBOX_1234
/// bssid => 00:01:02:03:F1:F2 (théoriquement unique dans le réseau scanné)

class AP{

  String _name;
  double _posXScreen;
  double _posYScreen;
  int _posXPixel = 0;
  int _posYPixel = 0;


  /// constructeur
  AP(this._name, this._posXScreen, this._posYScreen);


  /// getter et setter
  String get name => _name;
  set name(String value) {
    _name = value;
  }

  int get posXPixel => _posXPixel;
  set posXPixel(int value) {
    _posXPixel = value;
  }

  int get posYPixel => _posYPixel;
  set posYPixel(int value) {
    _posYPixel = value;
  }

  double get posXScreen => _posXScreen;
  set posXScreen(double value) {
    _posXScreen = value;
  }

  double get posYScreen => _posYScreen;
  set posYScreen(double value) {
    _posYScreen = value;
  }
}
