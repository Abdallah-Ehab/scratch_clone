import 'package:flutter/material.dart';
import 'package:scratch_clone/block_model.dart' as custom;
import 'package:scratch_clone/block_model.dart';
import 'package:scratch_clone/block_widget.dart';
import 'package:scratch_clone/stored_blocks.dart';
import 'package:scratch_clone/work_space.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
         body: Row(
      children: [
        Expanded(
          flex: 1,
            child: StoredBlocks()
        ),
        const Expanded(
          flex: 3,
          child: WorkSpace()
        )
      ],
    ));
  }
}
