// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pt _$PtFromJson(Map<String, dynamic> json) => Pt.WithParam(
      json['id'] as int,
      json['label'] as String,
      (json['posX'] as num).toDouble(),
      (json['posY'] as num).toDouble(),
      (json['radius'] as num).toDouble(),
    )
      ..timestamp = json['timestamp'] as int
      ..networks = (json['networks'] as List<dynamic>)
          .map((e) => Network.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PtToJson(Pt instance) => <String, dynamic>{
      'id': instance.id,
      'radius': instance.radius,
      'posY': instance.posY,
      'posX': instance.posX,
      'label': instance.label,
      'timestamp': instance.timestamp,
      'networks': instance.networks.map((e) => e.toJson()).toList(),
    };
