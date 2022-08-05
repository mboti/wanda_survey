//import 'package:matrix_gesture_mb/utils/ImportPlan.dart';
import 'package:json_annotation/json_annotation.dart';
/**
 * Classe permettant de gerer un plan de batiment
 */
part 'plan.g.dart';

@JsonSerializable()
class Plan{

  int? idPlan;
  String? pathImg;
  String? key;
  double? xMin, yMin, xMax, yMax;
  double? width;
  double? height;
  //ImportPlan importPlan = ImportPlan();

  Plan();
  Plan.WithParam(this.idPlan, this.pathImg, this.key, this.xMin, this.yMin, this.xMax, this.yMax, this.width, this.height);
  Plan.WithScreenCoordinatesAndImageCoordinate(this.xMin, this.yMin, this.xMax, this.yMax, this.width, this.height);
  Plan.WithScreenCoordinates(this.xMin, this.yMin, this.xMax, this.yMax);
  Plan.WithImageCoordinate(this.width, this.height);


  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);


  Map<String, dynamic> toJson() => _$PlanToJson(this);

}