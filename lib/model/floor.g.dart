// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Floor _$FloorFromJson(Map<String, dynamic> json) {
  return Floor(
      json['nameFloor'] as String,
      (json['altitudeFloor'] as num).toDouble(),
      (json['hauteurFloor'] as num).toDouble(),
    )
      ..plan = Plan.fromJson(json['plan'] as Map<String, dynamic>)
      ..ruler = Ruler.fromJson(json['ruler'] as Map<String, dynamic>)
      ..idFloor = json['idFloor'] as int
      ..pts = (json['pts'] as List<dynamic>)
          .map((e) => Pt.fromJson(e as Map<String, dynamic>))
          .toList()
      ..isDrawRuler = json['isDrawRuler'] as bool
      ..isDrawPt = json['isDrawPt'] as bool;
}

Map<String, dynamic> _$FloorToJson(Floor instance) {
  return <String, dynamic>{
      'plan': instance.plan.toJson(),
      'ruler': instance.ruler.toJson(),
      'idFloor': instance.idFloor,
      'pts': instance.pts.map((e) => e.toJson()).toList(),
      'hauteurFloor': instance.hauteurFloor,
      'altitudeFloor': instance.altitudeFloor,
      'nameFloor': instance.nameFloor,
      'isDrawRuler': instance.isDrawRuler,
      'isDrawPt': instance.isDrawPt,
    };
}
