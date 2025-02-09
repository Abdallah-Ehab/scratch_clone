import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scratch_clone/animation/animation_controller_provider.dart';
import 'package:scratch_clone/animation/frames_provider.dart';
import 'package:scratch_clone/animation/full_key_frames_provider.dart';
import 'package:scratch_clone/animation/game_object_manager_provider.dart';
import 'package:scratch_clone/animation/sketch_provider.dart';
import 'package:scratch_clone/block_state_provider.dart';
import 'package:scratch_clone/gameobject/game_object_page.dart';
import 'package:scratch_clone/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BlockStateProvider()),
        ChangeNotifierProvider(create: (context) => FramesProvider()),
        ChangeNotifierProvider(create: (context) => GameObjectManagerProvider()),
        ChangeNotifierProvider(create: (context) => SketchProvider()),
        ChangeNotifierProvider(create: (context) => AnimationControllerProvider(this)),
        ChangeNotifierProvider(create: (context) => FullKeyFramesProvider()), //used for tracking the fullKeyframe indices
      ],
      child: const MaterialApp(
        title: 'Scratch Clone',
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
