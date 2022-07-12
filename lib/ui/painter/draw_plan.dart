
/*
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<ui.Image> loadUiImage(String imageAssetPath) async {
  final ByteData data = await rootBundle.load(imageAssetPath);
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}


class DrawPlan {

  Image img = loadUiImage("images/plan2.jpg") as Image;
  // final ui.Image image;
  //
  // CanvasPainter(this.image);

  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / size.height);

    if(img!=null){
      canvas.drawImage(
          img,
          Offset.zero,
          ui.Paint()
            ..isAntiAlias = true
            ..filterQuality = ui.FilterQuality.high);
      canvas.restore();
    }

  }
}

*/
