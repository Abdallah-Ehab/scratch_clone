// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:scratch_clone/animation/animation_controller_provider.dart';
import 'package:scratch_clone/animation/animation_track.dart';
import 'package:scratch_clone/animation/frames_provider.dart';
import 'package:scratch_clone/animation/full_key_frames_provider.dart';
import 'package:scratch_clone/animation/game_object_manager_provider.dart';
import 'package:scratch_clone/animation/sketch_model.dart';
import 'package:scratch_clone/animation/sketch_provider.dart';
import 'package:scratch_clone/core/functions.dart';

// this code is used for :
//1- enablling the user to draw and adding each drawing to a list of sketches
//2- adding the list of sketches to the current frame
//3- use custompainter to draw the current frame
//4- use custompainter to draw the current frame drawing in the position of the tween
class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var sketchProvider = Provider.of<SketchProvider>(context);
    var frameProvider = Provider.of<FramesProvider>(context);
    var fullKeyFrameTracker = Provider.of<FullKeyFramesProvider>(context);
    var animationControllerProvider =
        Provider.of<AnimationControllerProvider>(context);
    var gameObjectProvider = Provider.of<GameObjectManagerProvider>(context);
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 400,
          child: GestureDetector(
              onPanStart: (details) {
                sketchProvider.currentSketch = SketchModel(
                    points: [details.localPosition],
                    color: sketchProvider.currentSketch.color,
                    strokeWidth: sketchProvider.currentSketch.strokeWidth);
                gameObjectProvider.addCurrentSketchToCurrentFrameInSelectedAnimationTrack(frameProvider.activeFrameIndex, sketchProvider.currentSketch);
              },
              onPanUpdate: (details) {
                sketchProvider.addPoint(details.localPosition);
                //log("${details.localPosition}");
                gameObjectProvider.addPointToTheLastSketchInTheFrame(frameProvider.activeFrameIndex, details.localPosition);
              },
              onPanEnd: (details){
                
              },
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.6),
                painter: AnimationPainter(
                  activeFrameIndex: frameProvider.activeFrameIndex,
                  animationTrack: gameObjectProvider.selectedAnimationTrack,
                  progress: animationControllerProvider.progress,
                  controllerProvider : animationControllerProvider,
                  fullKeyFrameIndices: fullKeyFrameTracker.fullKeyFrameIndices
                ),
              )),
        ),
      ],
    );
  }
}

class AnimationPainter extends CustomPainter {
  AnimationTrack animationTrack;
  double progress;
  int activeFrameIndex;
  AnimationControllerProvider controllerProvider;
  List<int> fullKeyFrameIndices;
  AnimationPainter({
    required this.animationTrack,
    required this.progress,
    required this.activeFrameIndex,
    required this.controllerProvider,
    required this.fullKeyFrameIndices,
  });

  @override
void paint(Canvas canvas, Size size) {
  if (animationTrack.keyFrames.isEmpty || 
      animationTrack.keyFrames[activeFrameIndex].sketches.data.isEmpty) return;

  // int previousFrameIndex = ((animationTrack.keyFrames.length - 1) * progress).floor();
  // int nextFrameIndex = ((animationTrack.keyFrames.length - 1) * progress).ceil();

  log("$fullKeyFrameIndices");
  int previousFrameIndex = ((fullKeyFrameIndices.length - 1) * progress).floor();
  int nextFrameIndex = ((fullKeyFrameIndices.length - 1) * progress).ceil();


  // Ensure valid indices
  previousFrameIndex = previousFrameIndex.clamp(0, fullKeyFrameIndices.length - 1);
  nextFrameIndex = nextFrameIndex.clamp(0, fullKeyFrameIndices.length - 1);
  

  int previousFullKeyFrameIndex = fullKeyFrameIndices[previousFrameIndex];
  int nextFullKeyFrameIndex = fullKeyFrameIndices[nextFrameIndex];
  // Interpolated values
  Offset positionInterpolation = lerpOffset(
      animationTrack.keyFrames[previousFullKeyFrameIndex].tweenData.position,
      animationTrack.keyFrames[nextFullKeyFrameIndex].tweenData.position,
      progress);
  double rotationInterpolation = lerpDouble(
      animationTrack.keyFrames[previousFullKeyFrameIndex].tweenData.rotation,
      animationTrack.keyFrames[nextFullKeyFrameIndex].tweenData.rotation,
      progress);
  double scaleInterpolation = lerpDouble(
      animationTrack.keyFrames[previousFullKeyFrameIndex].tweenData.scale,
      animationTrack.keyFrames[nextFullKeyFrameIndex].tweenData.scale,
      progress);

  // Set a custom origin (center of the frame may be later I will find a way to make it the center of the sketch it self)
  Offset origin = Offset(size.width / 2, size.height / 2);

  canvas.save();
  
  // Move to the new origin
  canvas.translate(origin.dx, origin.dy);

  if (controllerProvider.isPlaying) {
    canvas.translate(positionInterpolation.dx, positionInterpolation.dy);
    canvas.rotate(rotationInterpolation);
    canvas.scale(scaleInterpolation);
  } else {
    canvas.translate(
        animationTrack.keyFrames[activeFrameIndex].tweenData.position.dx,
        animationTrack.keyFrames[activeFrameIndex].tweenData.position.dy);
    canvas.rotate(animationTrack.keyFrames[activeFrameIndex].tweenData.rotation);
    canvas.scale(animationTrack.keyFrames[activeFrameIndex].tweenData.scale);
  }

  // Translate back so sketches are drawn at the correct position
  canvas.translate(-origin.dx, -origin.dy);

  // Draw sketches
  for (SketchModel sketch in animationTrack.keyFrames[activeFrameIndex].sketches.data) {
    Paint paint = Paint()
      ..color = sketch.color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = sketch.strokeWidth;

    for (int i = 0; i < sketch.points.length - 1; i++) {
      canvas.drawLine(sketch.points[i], sketch.points[i + 1], paint);
    }
  }

  canvas.restore();
}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
