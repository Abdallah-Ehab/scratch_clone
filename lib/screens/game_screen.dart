import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:scratch_clone/gameobject/game_object_widget.dart';
import 'package:scratch_clone/providers/gameObjectProviders/game_object_manager_provider.dart';
import 'package:scratch_clone/widgets/gameObjectWidgets/play_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    var gameManagerProvider = Provider.of<GameObjectManagerProvider>(context);
    return Scaffold(
      body: Container(
        color: Colors.blue,
        height: 500,
        width: 500,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 200,
                height: 50,
                child: const PlayButton(),
              ),
            ),
            ...gameManagerProvider.gameObjects.values.map((gameObject) {
              return Positioned(
                  top: gameObject.position.dy,
                  left: gameObject.position.dx,
                  child: GestureDetector(
                      onDoubleTap: () {
                        gameManagerProvider.playAnimation(
                            trackName: "idle", gameObject: gameObject);
                      },
                      onTap: () {
                        gameManagerProvider.currentGameObject = gameObject;
                        log("current gameObject is ${gameManagerProvider.currentGameObject}");
                      },
                      child: GameObjectWidget(gameObject: gameObject)));
            })
          ],
        ),
      ),
    );
  }
}
