// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:scratch_clone/animation/animation_track.dart';
import 'package:scratch_clone/animation/keyframe_model.dart';
import 'package:scratch_clone/animation/sketch_model.dart';

class GameObject {
  Map<String, AnimationTrack> animationTracks ={
        "idle":AnimationTrack(name: "idle",duration: 0.1,keyFrames: [])
      };
  Offset position;
  double rotation;
  double scale = 1.0;
  GameObject({
    required this.animationTracks,
    required this.position,
    required this.rotation,
    required this.scale,
  });

  KeyframeModel getCurrentKeyframe(String trackName, double progress) {
    var track = animationTracks[trackName];
    if (track == null || track.keyFrames.isEmpty) {
      return KeyframeModel(FrameByFrameKeyFrame(data: []), 0, TweenKeyFrame(position: Offset.zero, rotation: 0.0, scale: 1.0),keyFrameType.fullKey);
    }
    int index = (progress * track.keyFrames.length).floor().clamp(0, track.keyFrames.length - 1);
    return track.keyFrames[index];
  }
}



GameObject makeTheSketchAgameObject(SketchModel sketch) {
  return GameObject(
      position: const Offset(0, 0),
      rotation: 0.0,
      scale: 1.0,
      animationTracks: {
        "idle":AnimationTrack(name: "idle",duration: 0.1,keyFrames: [])
      });
}
