import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scratch_clone/animation/game_object_manager_provider.dart';

class MyDropDownMenu extends StatelessWidget {
  const MyDropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var gameObjectProvider = Provider.of<GameObjectManagerProvider>(context);
    return DropdownButton(
        items: gameObjectProvider.gameObjects.keys
            .map(
              (data) => DropdownMenuItem(
                child: Text(data),
              ),
            ).toList(),
        onChanged: (value) {
          gameObjectProvider.setCurrentGameObjectByName(value);
        });
  }
}
