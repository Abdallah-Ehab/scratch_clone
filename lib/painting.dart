// import 'dart:ui' as ui;

// //Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(311.59, 140.35), 
//     painter: RPSCustomPainter(),
// )

// //Copy this CustomPainter code to the Bottom of the File
// class RPSCustomPainter extends CustomPainter {
//     @override
//     void paint(Canvas canvas, Size size) {
            
// Path path_0 = Path();
//     path_0.moveTo(310.59,65.38);
//     path_0.lineTo(310.59,128.39);
//     path_0.cubicTo(310.59,134.45,305.67999999999995,139.35,299.63,139.35);
//     path_0.lineTo(183.81,139.35);
//     path_0.cubicTo(181.42000000000002,130.66,173.46,124.28,164.01,124.28);
//     path_0.cubicTo(154.55999999999997,124.28,146.60999999999999,130.66,144.22,139.35);
//     path_0.lineTo(11.96,139.35);
//     path_0.cubicTo(5.910000000000001,139.35,1,134.45,1,128.39);
//     path_0.lineTo(1,65.38);
//     path_0.cubicTo(1,59.33,5.91,54.419999999999995,11.96,54.419999999999995);
//     path_0.lineTo(33.900000000000006,54.419999999999995);
//     path_0.cubicTo(34.81,24.79,65.11,1,102.37,1);
//     path_0.cubicTo(139.63,1,169.93,24.79,170.84,54.42);
//     path_0.lineTo(299.63,54.42);
//     path_0.cubicTo(305.68,54.42,310.59,59.33,310.59,65.38);
//     path_0.close();

// Paint paint_0_stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.006418691;
// paint_0_stroke.color=Color(0xff00aeef).withOpacity(1.0);
// canvas.drawPath(path_0,paint_0_stroke);

// Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
// paint_0_fill.color = Color(0xff00aeef).withOpacity(1.0);
// canvas.drawPath(path_0,paint_0_fill);

// }

// @override
// bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
// }
// }