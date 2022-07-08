

/**
 * Classe décrivant les configurations d'un network
 */
class Network {

  String? _ssid;
  String? _bssid;
  String? _capability;
  int? _frequency;
  int? _level;
  int? _channel_width;
  int? _timestamp;

  Network(this._bssid, this._ssid, this._capability, this._frequency, this._level, this._channel_width, this._timestamp);

  String get bssid => _bssid!;

  set bssid(String value) {
    _bssid = value;
  }

  int get timestamp => _timestamp!;

  set timestamp(int value) {
    _timestamp = value;
  }

  int get channel_width => _channel_width!;

  set channel_width(int value) {
    _channel_width = value;
  }

  int get level => _level!;

  set level(int value) {
    _level = value;
  }

  int get frequency => _frequency!;

  set frequency(int value) {
    _frequency = value;
  }

  String get capability => _capability!;

  set capability(String value) {
    _capability = value;
  }

  String get ssid => _ssid!;

  set ssid(String value) {
    _ssid = value;
  }

  @override
  String toString() {
    return 'Network{_bssid: $_bssid, _ssid: $_ssid, _capability: $_capability, _frequency: $_frequency, _level: $_level, _channel_width: $_channel_width, _timestamp: $_timestamp}';
  }


}//Fin