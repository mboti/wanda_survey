// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Network _$NetworkFromJson(Map<String, dynamic> json) => Network(
      json['bssid'] as String,
      json['ssid'] as String,
      json['capability'] as String,
      json['frequency'] as int,
      json['level'] as int,
      json['channelWidth'] as int,
    );

Map<String, dynamic> _$NetworkToJson(Network instance) => <String, dynamic>{
      'bssid': instance.bssid,
      'channelWidth': instance.channelWidth,
      'level': instance.level,
      'frequency': instance.frequency,
      'capability': instance.capability,
      'ssid': instance.ssid,
    };
