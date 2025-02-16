import 'package:flutter/material.dart';
import 'package:scratch_clone/widgets/animationWidgets/animationWidget.dart';
import 'package:scratch_clone/widgets/animationWidgets/my_slider.dart';
import 'package:scratch_clone/widgets/animationWidgets/time_line_widget.dart';

class AnimationEditorScreen extends StatelessWidget {
  const AnimationEditorScreen({super.key});

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
            Animationwidget(),
            TimeLineWidget(),
          ],
        ),
      ),
    );
  }
}