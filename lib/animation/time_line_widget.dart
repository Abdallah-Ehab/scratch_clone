import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scratch_clone/animation/animation_controller_provider.dart';
import 'package:scratch_clone/animation/animation_track.dart';
import 'package:scratch_clone/animation/drop_down_menu2.dart';
import 'package:scratch_clone/animation/frames_provider.dart';
import 'package:scratch_clone/animation/full_key_frames_provider.dart';
import 'package:scratch_clone/animation/game_object.dart';
import 'package:scratch_clone/animation/game_object_manager_provider.dart';
import 'package:scratch_clone/animation/keyframe_model.dart';
import 'package:scratch_clone/animation/sketch_model.dart';

class TimeLineWidget extends StatefulWidget {
  const TimeLineWidget({super.key});

  @override
  State<TimeLineWidget> createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  late PageController _pageController;
  late TextEditingController _textController;
  @override
  void initState() {
    _pageController = PageController();
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var framesProvider = Provider.of<FramesProvider>(context);
    var gameObjectProvider = Provider.of<GameObjectManagerProvider>(context);
    var fullKeyFrameIndexTracker = Provider.of<FullKeyFramesProvider>(context);
    var animationControllerProvider = Provider.of<AnimationControllerProvider>(context);
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DropDownMenu2(),
              ElevatedButton(
                onPressed: () {
                  if (framesProvider.activeFrameIndex > 0) {
                    framesProvider.activeFrameIndex--;
                  }
                },
                child: const Text("prev frame"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (framesProvider.activeFrameIndex <
                      gameObjectProvider
                          .selectedAnimationTrack.keyFrames.length) {
                    framesProvider.activeFrameIndex++;
                  }
                },
                child: const Text("next frame"),
              ),
              ElevatedButton(
                onPressed: () {
                  animationControllerProvider.isPlaying = !animationControllerProvider.isPlaying;
                  GameObject currentGameObject =
                      gameObjectProvider.currentGameObject;

                  playAnimation(context, currentGameObject,
                      gameObjectProvider.selectedAnimationTrack);
                },
                child: const Text("play"),
              )
            ],
          ),
          SizedBox(
            height: 100,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                if (value <=
                    gameObjectProvider.selectedAnimationTrack.keyFrames.length -
                        1) {
                  framesProvider.activeFrameIndex = value;
                }
                log("$value");
                log("active frame index is ${framesProvider.activeFrameIndex}");
              },
              itemCount:
                  gameObjectProvider.selectedAnimationTrack.keyFrames.length +
                      1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index <
                    gameObjectProvider
                        .selectedAnimationTrack.keyFrames.length) {
                  if (gameObjectProvider
                          .selectedAnimationTrack.keyFrames[index].frameType ==
                      keyFrameType.fullKey) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      width: 50,
                      height: 100,
                      color: Colors.blue,
                      child: Center(child: Text("$index")),
                    );
                  }
                }
                return GestureDetector(
                  onTap: () {
                    gameObjectProvider.selectedAnimationTrack.keyFrames[index] =
                        KeyframeModel(
                            FrameByFrameKeyFrame(data: []),
                            index,
                            TweenKeyFrame(
                                position: const Offset(0, 0),
                                scale: 1.0,
                                rotation: 0.0),
                            keyFrameType.fullKey);
                    fullKeyFrameIndexTracker.addFullKeyFrameIndex(index);
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                              "choose the number of frames to insert"),
                          content: TextField(
                            controller: _textController,
                            decoration:
                                const InputDecoration(hintText: "no of frames"),
                            keyboardType: TextInputType.number,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                List<SketchModel> temp = gameObjectProvider.selectedAnimationTrack.keyFrames[framesProvider.activeFrameIndex].sketches.data;
                                int numberOfinsertedFrames =
                                    int.parse(_textController.text);
                                for (int i = 0;
                                    i < numberOfinsertedFrames;
                                    i++) {
                                  gameObjectProvider.addFrameToAnimationTrack(
                                      KeyframeModel(
                                          FrameByFrameKeyFrame(data: temp),
                                          index,
                                          TweenKeyFrame(
                                              position: const Offset(0, 0),
                                              scale: 1.0,
                                              rotation: 0.0),
                                          keyFrameType.blankKey));
                                }
                                
                                gameObjectProvider.addFrameToAnimationTrack(
                                    KeyframeModel(
                                        FrameByFrameKeyFrame(data: []),
                                        index,
                                        TweenKeyFrame(
                                            position: const Offset(0, 0),
                                            scale: 1.0,
                                            rotation: 0.0),
                                        keyFrameType.fullKey));
                                framesProvider.activeFrameIndex +=
                                    numberOfinsertedFrames+1;
                                gameObjectProvider.selectedAnimationTrack.keyFrames[framesProvider.activeFrameIndex].sketches.data = temp;
                                fullKeyFrameIndexTracker.addFullKeyFrameIndex(framesProvider.activeFrameIndex);
                              },
                              child: const Text("insert"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("cancel"),
                            )
                          ],
                        );
                      },
                    );
                    // gameObjectProvider.addFrameToAnimationTrack(
                    //     KeyframeModel(
                    //         FrameByFrameKeyFrame(data: []),
                    //         index,
                    //         TweenKeyFrame(
                    //             position: const Offset(0, 0),
                    //             scale: 1.0,
                    //             rotation: 0.0)));
                    // // animationControllerProvider.setDuration(
                    // //     gameObjectProvider.selectedAnimationTrack
                    // //             .keyFrames.length ~/
                    // //         12);
                    // framesProvider.activeFrameIndex++;
                    // sketchProvider.clearAllSketches();
                    // log("Added a new frame here is the data of the frame ${gameObjectProvider.selectedAnimationTrack.keyFrames[framesProvider.activeFrameIndex].frameNumber}");
                    // log("the list of all frames is ${gameObjectProvider.selectedAnimationTrack.keyFrames} and the activeFrameIndex is ${framesProvider.activeFrameIndex}");
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

 void playAnimation(BuildContext context, GameObject currentGameObject, AnimationTrack track) {
  var animationController = Provider.of<AnimationControllerProvider>(context, listen: false);

  if (track.keyFrames.isEmpty) return;

  int durationInSeconds = (track.keyFrames.length / 12).ceil();
  animationController.setDuration(durationInSeconds);

  animationController.controller.reset();
  animationController.controller.forward();

  // Remove previous listeners
  animationController.controller.removeStatusListener(_animationStatusListener);

  // Add status listener to detect when animation finishes
  animationController.controller.addStatusListener(_animationStatusListener);

  animationController.controller.removeListener(()=>_frameUpdateListener(track: track));
  animationController.controller.addListener(()=>_frameUpdateListener(track: track));
}


void _frameUpdateListener({required AnimationTrack track}) {
  var animationController = Provider.of<AnimationControllerProvider>(context, listen: false);
  var framesProvider = Provider.of<FramesProvider>(context, listen: false);
  
  int frameIndex = (animationController.progress * (track.keyFrames.length - 1)).round();

  if (frameIndex < track.keyFrames.length) {
    framesProvider.activeFrameIndex = frameIndex;
  }
}

// Status listener function
void _animationStatusListener(AnimationStatus status) {
  var animationController = Provider.of<AnimationControllerProvider>(context, listen: false);
  var framesProvider = Provider.of<FramesProvider>(context,listen: false);
  if (status == AnimationStatus.completed) {
    animationController.isPlaying = false;
    framesProvider.activeFrameIndex = 0;
  }
}
}
