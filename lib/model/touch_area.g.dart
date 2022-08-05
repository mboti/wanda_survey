// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'touch_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TouchArea _$TouchAreaFromJson(Map<String, dynamic> json) => TouchArea.WithParam(
      (json['zoom'] as num).toDouble(),
      json['isTablet'] as bool,
    );

Map<String, dynamic> _$TouchAreaToJson(TouchArea instance) => <String, dynamic>{
      'isTablet': instance.isTablet,
      'zoom': instance.zoom,
    };
