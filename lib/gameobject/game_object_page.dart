import 'package:flutter/material.dart';
import 'package:scratch_clone/animation/animation_page.dart';
import 'package:scratch_clone/animation/my_slider.dart';
import 'package:scratch_clone/animation/time_line_widget.dart';

class GameObjectPage extends StatelessWidget {
  const GameObjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const Drawer(
        backgroundColor: Colors.transparent,
        child: Center(child: MySlider()),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            AnimationPage(),
            TimeLineWidget(),
          ],
        ),
      ),
    );
  }
}
