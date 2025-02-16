import 'package:flutter/material.dart';
import 'package:scratch_clone/models/animationModels/animation_track.dart';
import 'package:scratch_clone/models/animationModels/keyframe_model.dart';
import 'package:scratch_clone/models/animationModels/sketch_model.dart';
import 'package:scratch_clone/models/blockModels/block_model.dart';
import 'package:scratch_clone/models/gameObjectModels/game_object.dart';
import 'package:scratch_clone/models/blockModels/block_model.dart' as custom;

class GameObjectManagerProvider extends ChangeNotifier {
  final TickerProvider vsync; // Store vsync reference

  Map<String, GameObject> gameObjects = {};

  late GameObject _currentGameObject;
  late AnimationTrack _selectedAnimationTrack;

  List<Offset> squarePoints = [
    const Offset(150, 150), // Top-left
    const Offset(250, 150), // Top-right
    const Offset(250, 250), // Bottom-right
    const Offset(150, 250), // Bottom-left
    const Offset(150, 150), // Closing the square
  ];

  GameObjectManagerProvider({required this.vsync}) {
    // Initialize the default GameObject inside the constructor
    gameObjects["empty"] = GameObject(
      name: "empty",
      width: 100,
      height: 100,
      animationTracks: {
        "idle": AnimationTrack(
          name: "idle",
          keyFrames: [
            KeyframeModel(
              FrameByFrameKeyFrame(data: [
                SketchModel(
                  points: squarePoints,
                  color: Colors.black,
                  strokeWidth: 1.0,
                )
              ]),
              1,
              TweenKeyFrame(
                position: const Offset(0, 0),
                rotation: 0.0,
                scale: 1.0,
              ),
              KeyFrameType.fullKey,
            ),
          ],
          duration: 0.0,
        ),
      },
      position: const Offset(150, 200),
      rotation: 0.0,
      vsync: vsync,
      blocksHead: BlockModel(
        position: const Offset(100, 100),
        code: "Generic Block",
        color: Colors.orange,
        source: Source.workSpace,
        state: custom.ConnectionState.disconnected,
        blockType: BlockType.inputoutput,
        width: 100.0,
        height: 90.0,
      ), // Pass vsync here
    );

    _currentGameObject = gameObjects["empty"]!;
    _selectedAnimationTrack = _currentGameObject.animationTracks["idle"]!;
  }

  void addGameObject(String name, GameObject gameObject) {
    gameObjects[name] = gameObject;
    notifyListeners();
  }

  GameObject get currentGameObject => _currentGameObject;

  set currentGameObject(GameObject gameObject) {
    _currentGameObject = gameObject;
    notifyListeners();
  }

  void addAnimationTrackToCurrentGameObject({
    required String name,
    required AnimationTrack animationTrack,
  }) {
    _currentGameObject.animationTracks[name] = animationTrack;
    notifyListeners();
  }

  AnimationTrack get selectedAnimationTrack => _selectedAnimationTrack;
  void setCurrentGameObjectByName(String name) {
    _currentGameObject = gameObjects[name]!;
    notifyListeners();
  }

  void setSelectedAnimationTrackByName(String name) {
    _selectedAnimationTrack = _currentGameObject.animationTracks[name]!;
    notifyListeners();
  }

  void addFrameToAnimationTrack(KeyframeModel keyFrame) {
    _selectedAnimationTrack.keyFrames.add(keyFrame);
    notifyListeners();
  }

  void addInbetweenFrameToAnimationTrack(int index, KeyframeModel keyFrame) {
    _selectedAnimationTrack.keyFrames[index] = keyFrame;
    notifyListeners();
  }

  void addCurrentSketchToCurrentFrameInSelectedAnimationTrack(
      int index, SketchModel currentSketch) {
    _selectedAnimationTrack.keyFrames[index].sketches.data.add(currentSketch);
    notifyListeners();
  }

  void changeGlobalPosition({double? dx, double? dy}) {
    var currentdx = _currentGameObject.position.dx;
    var currentdy = _currentGameObject.position.dy;
    if (dx == null && dy != null) {
      _currentGameObject.position = Offset(currentdx, dy);
    } else if (dx != null && dy == null) {
      _currentGameObject.position = Offset(dx, currentdy);
    } else if (dx != null && dy != null) {
      _currentGameObject.position = Offset(dx, dy);
    } else {
      return;
    }

    notifyListeners();
  }

  void changeGlobalRotation(double rotation) {
    _currentGameObject.rotation = rotation;
    notifyListeners();
  }

  void changeGlobalScale(double width, double height) {
    _currentGameObject.width = width;
    _currentGameObject.height = height;
    notifyListeners();
  }

  void changeLocalPosition(int index, {double? dx, double? dy}) {
    var currentdx = _currentGameObject
        .animationTracks[_selectedAnimationTrack.name]!
        .keyFrames[index]
        .tweenData
        .position
        .dx;
    var currentdy = _currentGameObject
        .animationTracks[_selectedAnimationTrack.name]!
        .keyFrames[index]
        .tweenData
        .position
        .dy;
    if (dx == null && dy != null) {
      _currentGameObject.animationTracks[_selectedAnimationTrack.name]!
          .keyFrames[index].tweenData.position = Offset(currentdx, dy);
    } else if (dx != null && dy == null) {
      _currentGameObject.animationTracks[_selectedAnimationTrack.name]!
          .keyFrames[index].tweenData.position = Offset(dx, currentdy);
    } else if (dx != null && dy != null) {
      _currentGameObject.animationTracks[_selectedAnimationTrack.name]!
          .keyFrames[index].tweenData.position = Offset(dx, dy);
    } else {
      return;
    }

    notifyListeners();
  }

  void changeLocalRotation(int index, {double rotation = 0}) {
    _currentGameObject.animationTracks[_selectedAnimationTrack.name]!
        .keyFrames[index].tweenData.rotation = rotation;
    notifyListeners();
  }

  void changeLocalScale(int index, {double scale = 0}) {
    _currentGameObject.animationTracks[_selectedAnimationTrack.name]!
        .keyFrames[index].tweenData.scale = scale;
    notifyListeners();
  }

  void addPointToTheLastSketchInTheFrame(
      int activeFrameIndex, Offset localPosition) {
    int lastIndex = _selectedAnimationTrack
            .keyFrames[activeFrameIndex].sketches.data.length -
        1;

    if (lastIndex >= 0) {
      _selectedAnimationTrack
          .keyFrames[activeFrameIndex].sketches.data[lastIndex].points
          .add(localPosition);

      notifyListeners();
    }
  }

  void playAnimation(
      {required String trackName, required GameObject gameObject}) {
    if (!gameObject.animationTracks.containsKey(trackName) ||
        gameObject.animationTracks[trackName]!.keyFrames.isEmpty) {
      return;
    }

    AnimationTrack track = gameObject.animationTracks[trackName]!;
    int durationInSeconds = (track.keyFrames.length / 12).ceil();
    gameObject.animationController.duration =
        Duration(seconds: durationInSeconds);

    gameObject.animationController.reset();
    gameObject.animationController.forward();

    // Remove previous listeners to avoid duplicates
    gameObject.animationController.removeStatusListener(
        (status) => _animationStatusListener(status, gameObject));
    gameObject.animationController.addStatusListener(
        (status) => _animationStatusListener(status, gameObject));

    gameObject.animationController.removeListener(
        () => _frameUpdateListener(track: track, gameObject: gameObject));
    gameObject.animationController.addListener(
        () => _frameUpdateListener(track: track, gameObject: gameObject));
  }

  void _frameUpdateListener(
      {required AnimationTrack track, required GameObject gameObject}) {
    int frameIndex =
        (gameObject.animationController.value * (track.keyFrames.length - 1))
            .round();
    if (frameIndex < track.keyFrames.length) {
      gameObject.activeFrameIndex = frameIndex;
      notifyListeners();
    }
  }

  void _animationStatusListener(AnimationStatus status, GameObject gameObject) {
    if (status == AnimationStatus.completed) {
      gameObject.animationPlaying = false;
      gameObject.activeFrameIndex = 0;
      notifyListeners();
    }
  }

  void createNewGameObject(String name) {
    // Define points for a square shape

    // Create a new GameObject with default properties
    GameObject newGameObject = GameObject(
        name: "empty",
        vsync: vsync,
        animationTracks: {
          "idle": AnimationTrack(
            name: "idle",
            keyFrames: [
              KeyframeModel(
                FrameByFrameKeyFrame(data: [
                  SketchModel(
                    points: squarePoints,
                    color: Colors.black,
                    strokeWidth: 1.0,
                  )
                ]),
                1,
                TweenKeyFrame(
                  position: const Offset(0, 0),
                  rotation: 0.0,
                  scale: 1.0,
                ),
                KeyFrameType.fullKey,
              ),
            ],
            duration: 0.0,
          ),
        },
        position: const Offset(0, 0),
        rotation: 0.0,
        width: 200.0,
        height: 200.0,
        activeFrameIndex: 0,
        animationPlaying: false,
        blocksHead: BlockModel(
          position: const Offset(100, 100),
          code: "Generic Block",
          color: Colors.orange,
          source: Source.workSpace,
          state: custom.ConnectionState.disconnected,
          blockType: BlockType.inputoutput,
          width: 100.0,
          height: 90.0,
        ));

    gameObjects[name] = newGameObject;

    notifyListeners();
  }

  void addBlockToWorkSpaceBlocks(BlockModel block) {
    _currentGameObject.workSpaceBlocks.add(block);
    notifyListeners();
  }

  void removeBlockFromWorkSpaceBlocks(BlockModel block) {
    _currentGameObject.workSpaceBlocks.remove(block);
    notifyListeners();
  }

  bool areAllBlocksConnected() {
    if (_currentGameObject.workSpaceBlocks.isEmpty)
      return true; // No blocks = already connected

    if (_currentGameObject.workSpaceBlocks.length > 1) {
      return false;
    } else {
      return true;
    }
  }

  void changeCurrentGameObjectName(String name) {
    _currentGameObject.name = name;
    notifyListeners();
  }
}
