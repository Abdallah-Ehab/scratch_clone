import 'package:scratch_clone/animation/keyframe_model.dart';

class AnimationTrack {
  String name;
  List<KeyframeModel> keyFrames;
  double duration;
  AnimationTrack({
    required this.name,
    required this.keyFrames,
    required this.duration,
  });
}