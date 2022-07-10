import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/model/ruler.dart';
import 'package:matrix_gesture_mb/ui/activity/activity_scene.dart';
import 'package:vector_math/vector_math_64.dart';





// ignore_for_file: avoid_print

typedef GestDetectorCallback = void Function(
      Matrix4 matrix,
      Matrix4 translationDeltaMatrix,
      Matrix4 scaleDeltaMatrix,
      Matrix4 rotationDeltaMatrix
    );

/// [ GestDetector ] détecte les gestes de translation, d'échelle et de rotation
/// et les combine dans un objet [Matrix4] qui peut être utilisé par le widget [Transform]
/// ou par le code [ CustomPainter ] de bas niveau. Vous pouvez personnaliser les types de
/// gestes rapportés en passant [ shouldTranslate ], [ shouldScale ] et [ shouldRotate ]parameters.





class GestDetector extends StatefulWidget {

  // [Matrix4] rappel de notification - callback
  final GestDetectorCallback onMatrixUpdate;

  // Le [child] contenu par ce détecteur. - widgets.child
  final Widget child;

  // [true] S'il faut détecter les gestes de translation lors du traitement de l'événement..
  static bool shouldTranslate = true;

  // [true] S'il faut détecter les gestes d'échelle lors du traitement de l'événement.
  final bool shouldScale;

  // [true] S'il faut détecter les gestes de rotation lors du traitement de l'événement.
  final bool shouldRotate;

  // [true] Si le widget [ ClipRect ] doit couper le widget [child]
  final bool clipChild;


  // Le comportement du test d'atteinte, transmis au GestureDetector sous-jacent.
  // Par défaut, HitTestBehavior.deferToChild
  final HitTestBehavior behavior;

  //Lorsqu'il est défini, il sera utilisé pour calculer un point focal "fixe" aligné par rapport à la taille de ce widget.
  final Alignment? focalPointAlignment;




  // constructeur
  const GestDetector({
    Key? key,
    required this.onMatrixUpdate,
    required this.child,
    shouldTranslate = true,
    this.shouldScale = true,
    this.shouldRotate = true,
    this.clipChild = true,
    this.focalPointAlignment,
    this.behavior = HitTestBehavior.deferToChild,
  })  : super(key: key);

  @override
  State<GestDetector> createState() => _GestDetectorState();



  /// Composez la matrice à partir des matrices de translation, d'échelle et de rotation -
  /// vous pouvez passer une valeur nulle pour ignorer toute matrice de la composition.
  /// Si [matrice] n'est pas nul, le résultat de la composition sera concaténé à cette [matrice],
  /// sinon la matrice identité sera utilisée.
  static Matrix4 compose(Matrix4? matrix, Matrix4? translationMatrix, Matrix4? scaleMatrix, Matrix4? rotationMatrix) {
    matrix ??= Matrix4.identity(); // if (matrix == null) matrix = Matrix4.identity();
    if (translationMatrix != null) matrix = translationMatrix * matrix;
    if (scaleMatrix != null) matrix = scaleMatrix * matrix;
    if (rotationMatrix != null) matrix = rotationMatrix * matrix;
    return matrix!;
  }


  /// Décompose [matrix] en composants
  ///   [MatrixDecomposedValues.translation],
  ///   [MatrixDecomposedValues.scale] et
  ///   [MatrixDecomposedValues.rotation].
  ///
  static MatrixDecomposedValues decomposeToValues(Matrix4 matrix) {
    var array = matrix.applyToVector3Array([0, 0, 0, 1, 0, 0]);
    Offset translation = Offset(array[0], array[1]);
    Offset delta = Offset(array[3] - array[0], array[4] - array[1]);
    double scale = delta.distance;
    double rotation = delta.direction;
    //MatrixDecomposedValues(translation, scale, rotation).toString();
    return MatrixDecomposedValues(translation, scale, rotation);
  }
}






class _GestDetectorState extends State<GestDetector> {
  late Offset _startingFocalPoint;
  late Offset _previousOffset;
  Offset _offset = Offset.zero;
  Offset offsetTouch = Offset.zero;  // coordonnée récupérer pendant le toucher et sauvegardé de manière à être transmis au 'doubleTouch' + 'LongTouch'
  Offset deltaTrans = Offset.zero;
  late double _previousZoom;
  double _zoom = 1.0;

  Matrix4 translationDeltaMatrix = Matrix4.identity();
  Matrix4 scaleDeltaMatrix = Matrix4.identity();
  Matrix4 rotationDeltaMatrix = Matrix4.identity();
  Matrix4 matrix = Matrix4.identity();


  @override
  Widget build(BuildContext context) {
    Widget child =
    widget.clipChild ? ClipRect(child: widget.child) : widget.child;
    return GestureDetector(
      behavior: widget.behavior,

      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,

      child: child,
    );
  }

  _ValueUpdater<Offset> translationUpdater = _ValueUpdater(
    value: Offset.zero,
    onUpdate: (oldVal, newVal) => newVal - oldVal,
  );
  _ValueUpdater<double> scaleUpdater = _ValueUpdater(
    value: 1.0,
    onUpdate: (oldVal, newVal) => newVal / oldVal,
  );
  _ValueUpdater<double> rotationUpdater = _ValueUpdater(
    value: 0.0,
    onUpdate: (oldVal, newVal) => newVal - oldVal,
  );

  void onScaleStart(ScaleStartDetails details) {
    translationUpdater.value = details.focalPoint;
    scaleUpdater.value = 1.0;
    rotationUpdater.value = 0.0;
    //TODO MBO
    if(Project.bDebugMode) { print("onScaleStart---${details.localFocalPoint}");}
    setState(() {
      _startingFocalPoint = details.focalPoint;
      _previousOffset = _offset;
      _previousZoom = _zoom;
    });//TODO MBO END
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    /// notifier un repaint de la scene /!\ sans cette commande impossible de
    /// rafraichir la scene lorsque je déplace ke ruler par exemeple
    ActivitySceneState.repaintNotifier.value++;

    translationDeltaMatrix = Matrix4.identity();
    scaleDeltaMatrix = Matrix4.identity();
    rotationDeltaMatrix = Matrix4.identity();

    /// gère la translation de la matrice
    /// ------------------------------------------------------------------------
    //if (widget.shouldTranslate) {
    if (GestDetector.shouldTranslate) {
      Offset translationDelta = translationUpdater.update(details.focalPoint);
      translationDeltaMatrix = _translate(translationDelta);
      matrix = translationDeltaMatrix * matrix;
    }

    final focalPointAlignment = widget.focalPointAlignment;
    final focalPoint = focalPointAlignment == null ?
    details.localFocalPoint :
    focalPointAlignment.alongSize(context.size!);

    /// gère la mise à l'echelle de la matrice
    /// ------------------------------------------------------------------------
    if (widget.shouldScale && details.scale != 1.0) {
      double scaleDelta = scaleUpdater.update(details.scale);
      scaleDeltaMatrix = _scale(scaleDelta, focalPoint);
      matrix = scaleDeltaMatrix * matrix;
    }

    /// gère la rotation de la matrice
    /// ------------------------------------------------------------------------
    if (widget.shouldRotate && details.rotation != 0.0) {
      double rotationDelta = rotationUpdater.update(details.rotation);
      rotationDeltaMatrix = _rotate(rotationDelta, focalPoint);
      matrix = rotationDeltaMatrix * matrix;
    }
    /// ------------------------------------------------------------------------


    widget.onMatrixUpdate(matrix, translationDeltaMatrix, scaleDeltaMatrix, rotationDeltaMatrix);

    if(Project.bDebugMode) { print("onScaleUpdateF---${details.localFocalPoint}");}
    setState(() {
      _zoom = _previousZoom * details.scale;
      Project().touchArea?.zoom = _zoom;

      // Assurez-vous que l'élément sous le point focal reste au même endroit malgré le zoom
      final Offset normalizedOffset = (_startingFocalPoint - _previousOffset) / _previousZoom;
      _offset = details.focalPoint - normalizedOffset * _zoom;

      Offset pt =  coordScreenToScene(matrix, details.localFocalPoint);
      if(Project.bDebugMode) { print("onScaleUpdateFFF---${pt.toString()}");}

      print("zoom $_zoom  /   _previousZoom  $_previousZoom");

      //calculé le vecteur "delta" entre le doigt et le point souhaité qu'une seule fois au moment du touché
      if(deltaTrans == Offset.zero){
        var x = Project().getFloor(0)?.ruler.georefX;
        var y = Project().getFloor(0)?.ruler.georefY;
        deltaTrans= Offset(x!-offsetTouch.dx, y!-offsetTouch.dy);
      }

      //MAJ des coordonnées du Ruler et interdire la modification du ruler lorsque je fais un zoom
      if(_zoom == _previousZoom){
        Project().getFloor(0)?.ruler.georefX = pt.dx + deltaTrans.dx;
        Project().getFloor(0)?.ruler.georefY = pt.dy + deltaTrans.dy;
      }

      if(Project.bDebugMode) { print("coord pointer X: ${Project().getFloor(0)?.ruler.georefX.toString()}  Y: ${Project().getFloor(0)?.ruler.georefY.toString()}");}
    });
  }

  void onScaleEnd(ScaleEndDetails details) {
    if(Project.bDebugMode) { print("onScaleEnd-----------------------------------");}
    /// Réinitialiser le repaint à zéro lorsque j'ai retiré mon doigt de l'écran
    ActivitySceneState.repaintNotifier.value=0;
    /// Réinitialiser le delta entre le toucher du doigt est un objet
    deltaTrans = Offset.zero;
  }

  void onTapDown(TapDownDetails details)  {
    offsetTouch =  coordScreenToScene(matrix, details.localPosition);
    if(Project.bDebugMode) { print("onTapDown------${offsetTouch.toString()}");}

    isOverRuler(offsetTouch);
    isOverPt(offsetTouch);
  }

  void onTapUp(TapUpDetails details)  {
    offsetTouch =  coordScreenToScene(matrix, details.localPosition);
    if(Project.bDebugMode) { print("onTapUp------${offsetTouch.toString()}");}

  }

  //TODO MBO
  void onDoubleTap() {
    if(Project.bDebugMode) { print("onDoubleTap--------------------------${offsetTouch.toString()}");}
    GestDetector.shouldTranslate ? (GestDetector.shouldTranslate=false) : (GestDetector.shouldTranslate=true);
  }

  //TODO MBO
  void onLongPress() {
    if(Project.bDebugMode) { print("onLongPress--------------------------${offsetTouch.toString()}");}
  }

  Matrix4 _translate(Offset translation) {
    var dx = translation.dx;
    var dy = translation.dy;

    return Matrix4( 1, 0, 0, 0,  /*[0]  = 1 => x scale */
                    0, 1, 0, 0,  /*[5]  = 1 => y scale*/
                    0, 0, 1, 0,  /*[10] = 1 => diagonal "one"*/
                    dx, dy, 0, 1 /*[12] = dx => x translation,  [13] = dy => y translation,   [15] = 1  => diagonal "one"*/
                  );
  }

  Matrix4 _scale(double scale, Offset focalPoint) {
    var dx = (1 - scale) * focalPoint.dx;
    var dy = (1 - scale) * focalPoint.dy;

    return Matrix4( scale, 0, 0, 0, /*[0]  = scale => x scale */
                    0, scale, 0, 0, /*[5]  = scale => y scale*/
                    0, 0, 1, 0,     /*[10] = 1 => diagonal "one"*/
                    dx, dy, 0, 1    /*[12] = dx => x translation,  [13] = dy => y translation,   [15] = 1  => diagonal "one"*/
                  );
  }

  Matrix4 _rotate(double angle, Offset focalPoint) {
    var c = cos(angle);
    var s = sin(angle);
    var dx = (1 - c) * focalPoint.dx + s * focalPoint.dy;
    var dy = (1 - c) * focalPoint.dy - s * focalPoint.dx;

    return Matrix4(c, s, 0, 0, /*[0]  = c  => x scale,   [1]  = s => y skew*/
                  -s, c, 0, 0, /*[4]  = -s => x skew,    [5]  = c => y scale*/
                  0, 0, 1, 0,  /*[10] = 1 => diagonal "one"*/
                  dx, dy, 0, 1 /*[12] = dx => x translation,  [13] = dy => y translation,   [15] = 1  => diagonal "one"*/
                );
  }

  /// Convertire la position (coordonnée) du doigt écran en coordonnées Scene
  static Offset coordScreenToScene(Matrix4 transform, Offset point) {
    Matrix4 mt = Matrix4.copy(transform)..invert();
    final Vector3 position3 = Vector3(point.dx, point.dy, 0.0);
    final Vector3 transformed3 = mt.transform3(position3);  //final Vector3 transformed3 = mt.perspectiveTransform(position3);
    // MAJ de la zone de contact
    Project().touchArea?.updateArea(transformed3.x, transformed3.y);
    if(Project.bDebugMode) { print(Project().touchArea.toString());}

    return Offset(transformed3.x, transformed3.y);
  }






  isOverRuler(Offset offsetTouch) {
    Ruler? ruler = Project().getFloor(0)?.ruler;
    bool? isOverPtRef = Project().touchArea?.isFingerOverObject(ruler!.georefX,ruler.georefY);
    bool? isOverPtScale = Project().touchArea?.isFingerOverObject(ruler!.scaleX,ruler.scaleY);

    if(isOverPtRef!){
      if(Project.bDebugMode) { print("je suis sur le point de Référence");}
      GestDetector.shouldTranslate=false;
    }
    if(isOverPtScale!){
      if(Project.bDebugMode) { print("je suis sur le point de Scale");}
      GestDetector.shouldTranslate=false;
    }
  }


  isOverPt(Offset offsetTouch) {

  }


}




typedef _OnUpdate<T> = T Function(T oldValue, T newValue);


class _ValueUpdater<T> {
  final _OnUpdate<T> onUpdate;
  T value;

  _ValueUpdater({
    required this.value,
    required this.onUpdate,
  });

  T update(T newValue) {
    T updated = onUpdate(value, newValue);
    value = newValue;
    return updated;
  }
}


class MatrixDecomposedValues {
  // Translation, dans la plupart des cas utile uniquement pour les matrices qui ne sont rien d'autre qu'une translation (pas d'échelle et de rotation).
  final Offset translation;

  // Facteur d'échelle.
  final double scale;

  // Rotation en radians, plage (-pi..pi).
  final double rotation;

  MatrixDecomposedValues(this.translation, this.scale, this.rotation);

  @override
  String toString() {
    return 'MatrixDecomposedValues(translation: $translation, scale: ${scale.toStringAsFixed(3)}, rotation: ${rotation.toStringAsFixed(3)})';
  }
}
