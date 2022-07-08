

/// ssid  =>  LIVEBOX_1234
/// bssid => 00:01:02:03:F1:F2 (théoriquement unique dans le réseau scanné)

class AP{

  String _name;
  double _posX;
  double _posY;


  AP(this._name, this._posX, this._posY);

  double get posY => _posY;

  set posY(double value) {
    _posY = value;
  }

  double get posX => _posX;

  set posX(double value) {
    _posX = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
