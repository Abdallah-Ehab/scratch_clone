import 'dart:ui';

class SketchModel {
  List<Offset> points;
  Color color;
  double strokeWidth;

  SketchModel({
    required this.points,
    required this.color,
    required this.strokeWidth,
  });
}