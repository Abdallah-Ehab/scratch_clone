// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Offset shapeOffset = const Offset(100, 100);
//   Offset staticShapeOffset = const Offset(200, 200);
//   bool isDropped = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Draggable Shape with DragTarget'),
//       ),
//       body: Stack(
//         children: [
//           // Static canvas background
//           Positioned.fill(
//             child: CustomPaint(
//               painter: CanvasPainter(), // Optional background painter
//             ),
//           ),

//           // Static shape (DragTarget)
//           Positioned(
//             left: staticShapeOffset.dx,
//             top: staticShapeOffset.dy,
//             child: DragTarget<int>(
//               onAcceptWithDetails: (data) {
//                 setState(() {
//                   shapeOffset = staticShapeOffset;
//                   isDropped = true;
//                 });
//               },
//               builder: (context, candidateData, rejectedData) {
//                 return _buildStaticShape();
//               },
//             ),
//           ),

//           // Draggable shape
//           Positioned(
//             left: shapeOffset.dx,
//             top: shapeOffset.dy,
//             child: Draggable<int>(
//               data: 1, // The data passed to the DragTarget
//               feedback: _buildDraggableShape(context), // Shape in its original position
//               childWhenDragging: Opacity(
//                 opacity: 0.5, // Semi-transparent while dragging
//                 child: _buildDraggableShape(context),
//               ),
//               onDragEnd: (details) {
//                 setState(() {
//                   // Check if the draggable shape is close enough to snap
//                   if ((details.offset - staticShapeOffset).distance < 100) {
//                     shapeOffset = staticShapeOffset + const Offset(0, 0.3*200);
//                   } else {
//                     shapeOffset = details.offset - const Offset(0, 50);
//                   }
//                 });
//               }, // Shape shown during dragging
//               child: _buildDraggableShape(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStaticShape() {
//     return Stack(
//       children: [
//         CustomPaint(
//           size: const Size(200, 200),
//           painter: StaticBlockPainter(),
//         ),
//         const Positioned.fill(
//           child: Center(
//             child: Text("Connect Here"),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDraggableShape(BuildContext context) {
//     return Material(
//       // Wrap in Material to prevent the "no Material widget" error
//       color: Colors.transparent,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           CustomPaint(
//             size: const Size(200, 200),
//             painter: BlockPainter(),
//           ),
//           const Positioned.fill(
//             child: Center(
//               child: SizedBox(
//                 width: 100,
//                 height: 25,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Enter text',
//                     hintStyle: TextStyle(color: Colors.black, fontSize: 14),
//                     fillColor: Colors.white,
//                     filled: true,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CanvasPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Draw a white background for the canvas
//     canvas.drawRect(
//       Offset.zero & size,
//       Paint()..color = Colors.white,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class StaticBlockPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Draw a simple static block
//     Paint paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;

//     double width = size.width * 0.6;
//     double height = size.height * 0.3;
//     double left = (size.width - width) / 2; 
//     double top = (size.height - height) / 2;
//     Rect rect = Rect.fromLTWH(left, top, width, height);
//     Rect oval = Rect.fromCircle(center: Offset(width / 2, top), radius: 10);
//     Rect indent = Rect.fromCircle(center: Offset(size.width / 2, top + height), radius: 10);
//     Path path = Path()
//       ..addRect(rect)
//       ..addOval(oval);
//     Path circlePath = Path()..addOval(indent);
//     Path resultPath = Path.combine(PathOperation.difference, path, circlePath);
//     canvas.drawPath(
//       resultPath,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class BlockPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Draw a draggable block
//     Paint paint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.fill;
//     double width = size.width * 0.6;
//     double height = size.height * 0.3;
//     double left = (size.width - width) / 2; 
//     double top = (size.height - height) / 2;
//     Rect rect = Rect.fromLTWH(left, top, width, height);
//     Rect oval = Rect.fromCircle(center: Offset(size.width / 2, top), radius: 10);
//     Rect indent = Rect.fromCircle(center: Offset(size.width / 2, top + height), radius: 10);
//     Path path = Path()
//       ..addRect(rect)
//       ..addOval(oval);
//     Path circlePath = Path()..addOval(indent);
//     Path resultPath = Path.combine(PathOperation.difference, path, circlePath);
//     canvas.drawPath(
//       resultPath,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
