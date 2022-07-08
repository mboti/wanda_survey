import 'package:matrix_gesture_mb/utils/ImportPlan.dart';

/**
 * Classe permettant de gerer un plan de batiment
 */
class Plan{

  int? idPlan;
  String? pathImg;
  String? key;
  double? xMin, yMin, xMax, yMax;
  double? width;
  double? height;
  ImportPlan importPlan = ImportPlan();

  Plan(this.idPlan, this.pathImg, this.key, this.xMin, this.yMin, this.xMax, this.yMax, this.width, this.height);
  Plan.WithScreenCoordinatesAndImageCoordinate(this.xMin, this.yMin, this.xMax, this.yMax, this.width, this.height);
  Plan.WithScreenCoordinates(this.xMin, this.yMin, this.xMax, this.yMax);
  Plan.WithImageCoordinate(this.width, this.height);


}