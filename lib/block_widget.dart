// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:scratch_clone/block_model.dart';
import 'package:scratch_clone/home_screen.dart';

class BlockWidget extends StatelessWidget {
  final BlockModel blockModel;
  final Color color;
  const BlockWidget({super.key, required this.blockModel, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(100, 100),
          painter: BlockPainter(color: color),
        ),
        Text(
          blockModel.code,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class BlockPainter extends CustomPainter {
  final Color color;
  const BlockPainter({
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    double width = size.width * 0.6;
    double height = size.height * 0.3;
    double left = (size.width - width) / 2;
    double top = (size.height - height) / 2;
    Rect rect = Rect.fromLTWH(left, top, width, height);
    Rect oval =
        Rect.fromCircle(center: Offset(size.width / 2, top), radius: 10);
    Rect indent = Rect.fromCircle(
        center: Offset(size.width / 2, top + height), radius: 10);
    Path path = Path()
      ..addRect(rect)
      ..addOval(oval);
    Path circlePath = Path()..addOval(indent);
    Path resultPath = Path.combine(PathOperation.difference, path, circlePath);
    canvas.drawPath(
      resultPath,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
