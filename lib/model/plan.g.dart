// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan.WithParam(
      json['idPlan'] as int?,
      json['pathImg'] as String?,
      json['key'] as String?,
      (json['xMin'] as num?)?.toDouble(),
      (json['yMin'] as num?)?.toDouble(),
      (json['xMax'] as num?)?.toDouble(),
      (json['yMax'] as num?)?.toDouble(),
      (json['width'] as num?)?.toDouble(),
      (json['height'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'idPlan': instance.idPlan,
      'pathImg': instance.pathImg,
      'key': instance.key,
      'xMin': instance.xMin,
      'yMin': instance.yMin,
      'xMax': instance.xMax,
      'yMax': instance.yMax,
      'width': instance.width,
      'height': instance.height,
    };
