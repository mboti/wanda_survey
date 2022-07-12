import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

const kCanvasSize = 300.0;

class ActivityPaintImage extends StatefulWidget {
  const ActivityPaintImage({Key? key}) : super(key: key);

  @override
  State<ActivityPaintImage> createState() => _ActivityPaintImageState();
}

class _ActivityPaintImageState extends State<ActivityPaintImage> {
  ui.Image? image;

  @override
  void initState() {
    _load('images/plan2.jpg');
    super.initState();
  }

  void _load(String path) async {
    var bytes = await rootBundle.load(path);
    image = await decodeImageFromList(bytes.buffer.asUint8List());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.greenAccent, width: 2)),
          height: kCanvasSize,
          width: kCanvasSize,
          child: CustomPaint(
            painter: ImageInsideRectangle(context: context, image: image),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

Future<ui.Image> loadUiImage(String imageAssetPath) async {
  final ByteData data = await rootBundle.load(imageAssetPath);
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}

class ImageInsideRectangle extends CustomPainter {
  ImageInsideRectangle({required this.context, required this.image});
  ui.Image? image;
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) async {
    Paint greenBrush = Paint()..color = Colors.greenAccent;
    if (image != null) {
      canvas.save();
      canvas.scale(kCanvasSize / image!.height);
      canvas.drawImage(image!, const Offset(0, 0), greenBrush);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


/*
class ImageInsideRectangle extends CustomPainter {
  ImageInsideRectangle({required this.context, required this.image});
  ui.Image? image;
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) async {
    canvas.clipRRect(ui.RRect.fromRectXY(
      Rect.fromPoints(const Offset(0, 0), const Offset(kCanvasSize - 4, kCanvasSize - 4)),
      0,
      0,
    ));
    Paint greenBrush = Paint()..color = Colors.greenAccent;
    if (image != null) {
      canvas.save();
      rotate(
          canvas: canvas,
          cx: image!.width.toDouble() / 2,
          cy: image!.height.toDouble() / 2,
          angle: -0.3);
      canvas.scale(kCanvasSize / image!.height);
      canvas.drawImage(image!, const Offset(0, 0), greenBrush);
      canvas.restore();
    }
    canvas.save();
    rotate(canvas: canvas, cx: 200 + 50, cy: 100 + 50, angle: 0.5);
    canvas.drawRect(const Rect.fromLTWH(200, 100, 100, 100), greenBrush);
    canvas.restore();
  }

  void rotate(
      {required Canvas canvas,
        required double cx,
        required double cy,
        required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
 */