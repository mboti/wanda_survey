// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruler.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ruler _$RulerFromJson(Map<String, dynamic> json) => Ruler()
  ..rateRulerVsW = (json['rateRulerVsW'] as num).toDouble()
  ..georefX = (json['georefX'] as num).toDouble()
  ..georefY = (json['georefY'] as num).toDouble()
  ..scaleX = (json['scaleX'] as num).toDouble()
  ..scaleY = (json['scaleY'] as num).toDouble()
  ..lengthMeter = (json['lengthMeter'] as num).toDouble();

Map<String, dynamic> _$RulerToJson(Ruler instance) => <String, dynamic>{
      'rateRulerVsW': instance.rateRulerVsW,
      'georefX': instance.georefX,
      'georefY': instance.georefY,
      'scaleX': instance.scaleX,
      'scaleY': instance.scaleY,
      'lengthMeter': instance.lengthMeter,
    };
