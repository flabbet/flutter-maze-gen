import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maze_gen/maze_generator.dart';

class OpenPainter extends CustomPainter {

  MazeGenerator mazeGen;

  OpenPainter(this.mazeGen);

@override
void paint(Canvas canvas, Size size) {
  final pointMode = PointMode.points;
  final points = mazeGen.getDrawPoints();
  final paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 1
    ..strokeCap = StrokeCap.square;
    canvas.scale(7);
    canvas.drawPoints(pointMode,points, paint);
  canvas.save();
  canvas.restore();
}
 @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}