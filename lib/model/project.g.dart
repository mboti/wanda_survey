// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project()
  ..touchArea = json['touchArea'] == null
      ? null
      : TouchArea.fromJson(json['touchArea'] as Map<String, dynamic>)
  ..idProject = json['idProject'] as int
  ..name = json['name'] as String
  ..isTablet = json['isTablet'] as bool
  ..heightFloor = (json['heightFloor'] as num).toDouble()
  ..floors = (json['floors'] as List<dynamic>)
      .map((e) => Floor.fromJson(e as Map<String, dynamic>))
      .toList()
  ..W_screen = (json['W_screen'] as num).toDouble()
  ..H_screen = (json['H_screen'] as num).toDouble()
  ..nameDefaultPlan = json['nameDefaultPlan'] as String;

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'touchArea': instance.touchArea?.toJson(),
      'idProject': instance.idProject,
      'name': instance.name,
      'isTablet': instance.isTablet,
      'heightFloor': instance.heightFloor,
      'floors': instance.floors.map((e) => e.toJson()).toList(),
      'W_screen': instance.W_screen,
      'H_screen': instance.H_screen,
      'nameDefaultPlan': instance.nameDefaultPlan,
    };
