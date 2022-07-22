import 'package:flutter/material.dart';

/**
 * Classe permettent d'appliquer un certain nombre de mise en forme à nos textes.
 */
class MyCustumText extends Text{

  MyCustumText(String data, {color: Colors.black, textAlign: TextAlign.center, factor: 1.0}):
      super(
        data,
        textAlign: textAlign,
        textScaleFactor: factor,
        style: new TextStyle(color: color)
      );

}