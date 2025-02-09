import 'package:flutter/material.dart';
import 'package:scratch_clone/animation/animation_track.dart';
import 'package:scratch_clone/animation/game_object.dart';
import 'package:scratch_clone/animation/keyframe_model.dart';
import 'package:scratch_clone/animation/sketch_model.dart';

class GameObjectManagerProvider extends ChangeNotifier {
  Map<String, GameObject> gameObjects = {
    "empty": GameObject(
      animationTracks: {
        "idle": AnimationTrack(
            name: "idle",
            keyFrames: [
              KeyframeModel(
                  FrameByFrameKeyFrame(data: [
                    SketchModel(
                        points: [const Offset(0, 0)],
                        color: Colors.black,
                        strokeWidth: 1.0)
                  ]),
                  1,
                  TweenKeyFrame(
                      position: const Offset(0, 0), rotation: 0.0, scale: 1.0),keyFrameType.fullKey)
            ],
            duration: 0.0)
      },
      position: const Offset(0, 0),
      rotation: 0.0,
      scale: 1.0,
    )
  };

  late GameObject _currentGameObject = gameObjects["empty"]!;
  late AnimationTrack _selectedAnimationTrack = AnimationTrack(
      name: "idle",
      keyFrames: [
        KeyframeModel(
          FrameByFrameKeyFrame(data: [
            SketchModel(
                points: [const Offset(0, 0)],
                color: Colors.black,
                strokeWidth: 1.0)
          ]),
          1,
          TweenKeyFrame(
              position: const Offset(0, 0), rotation: 0.0, scale: 1.0),
          keyFrameType.fullKey,
        )
      ],
      duration: 0.0);

  void addGameObject(String name, GameObject gameObject) {
    gameObjects[name] = gameObject;
  }

  void setCurrentGameObjectByName(String name) {
    if (gameObjects[name] == null) {
      gameObjects[name] = GameObject(
        animationTracks: {
          "idle": AnimationTrack(name: "idle", keyFrames: [], duration: 0.0)
        },
        position: const Offset(0, 0),
        rotation: 0.0,
        scale: 1.0,
      );
    }
    _currentGameObject = gameObjects[name]!;
    notifyListeners();
  }

  GameObject get currentGameObject => _currentGameObject;

  set currentGameObject(GameObject gameObject) {
    _currentGameObject = gameObject;
    notifyListeners();
  }

  void addAnimationTrackToCurrentGameObject(
      {required String name, required AnimationTrack animationTrack}) {
    _currentGameObject.animationTracks[name] = animationTrack;
    notifyListeners();
  }

  AnimationTrack get selectedAnimationTrack => _selectedAnimationTrack;

  void setSelectedAnimationTrackByName(String name) {
    _selectedAnimationTrack = _currentGameObject.animationTracks[name]!;
    notifyListeners();
  }

  void addFrameToAnimationTrack(KeyframeModel keyFrame) {
    _selectedAnimationTrack.keyFrames.add(keyFrame);
    notifyListeners();
  }

  void addCurrentSketchToCurrentFrameInSelectedAnimationTrack(
      int index, SketchModel currentSketch) {
    _selectedAnimationTrack.keyFrames[index].sketches.data.add(currentSketch);
    notifyListeners();
  }

  
  void changeLocalPosition(int index, {double dx = 0, double dy = 0}) {
    _selectedAnimationTrack.keyFrames[index].tweenData.position =
        Offset(dx, dy);
    notifyListeners();
  }

  void changeLocalRotation(int index, {double rotation = 0}) {
    _selectedAnimationTrack.keyFrames[index].tweenData.rotation = rotation;
    notifyListeners();
  }

  void changeLocalScale(int index, {double scale = 0}) {
    _selectedAnimationTrack.keyFrames[index].tweenData.scale = scale;
    notifyListeners();
  }

  void addPointToTheLastSketchInTheFrame(int activeFrameIndex,Offset localPosition){
     int lastIndex = _selectedAnimationTrack.keyFrames[activeFrameIndex].sketches.data.length - 1;
  
  if (lastIndex >= 0) {
    _selectedAnimationTrack
      .keyFrames[activeFrameIndex]
      .sketches.data[lastIndex]
      .points
      .add(localPosition);
    
    notifyListeners();
  }
}
}
