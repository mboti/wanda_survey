import 'package:json_annotation/json_annotation.dart';

///Classe décrivant les configurations d'un network



part 'network.g.dart';

@JsonSerializable()
class Network {

  String? _ssid;
  String? _bssid;
  String? _capability;
  int? _frequency;
  int? _level;
  int? _channelWidth;


  Network(String bssid, String ssid, String capability, int frequency, int level, int channelWidth) {
    _bssid = bssid;
    _ssid = ssid;
    _capability = capability;
    _frequency = frequency;
    _level = level;
    _channelWidth = channelWidth;
  }

  String get bssid => _bssid!;

  set bssid(String value) {
    _bssid = value;
  }

  int get channelWidth => _channelWidth!;

  set channelWidth(int value) {
    _channelWidth = value;
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
    return 'Network{_bssid: $_bssid, _ssid: $_ssid, _capability: $_capability, _frequency: $_frequency, _level: $_level, _channel_width: $_channelWidth}';
  }

  factory Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);


  Map<String, dynamic> toJson() => _$NetworkToJson(this);



}//Fin