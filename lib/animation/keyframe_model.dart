// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:scratch_clone/animation/sketch_model.dart';


enum keyFrameType{
  blankKey,
  fullKey
}
class KeyframeModel {

  int frameNumber;
  FrameByFrameKeyFrame sketches;
  TweenKeyFrame tweenData;
  keyFrameType frameType;
  
  KeyframeModel( this.sketches,this.frameNumber,this.tweenData,this.frameType);
}

class FrameByFrameKeyFrame {
  List<SketchModel> data;
  FrameByFrameKeyFrame({
    required this.data,
  });
}

class TweenKeyFrame {
  

  Offset position;
  double rotation;
  double scale;
  
  TweenKeyFrame({
   
 
    required this.position,
    required this.rotation,
    required this.scale,
  });


  
  
}


