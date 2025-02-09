import 'dart:developer';

import 'package:dart_eval/dart_eval.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scratch_clone/block_state_provider.dart';
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: StoredBlocks(),
                ),
                const Expanded(
                  flex: 3,
                  child: WorkSpace(),
                ),
              ],
            ),
            Align(
             alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(10),
                width:200,
                height: 50,
                child: ElevatedButton(
                  
                  onPressed: ()=>executeCode(context),
                  child: const Text("Run Code"),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  void executeCode(BuildContext context){
    
    
    var blockProvider = Provider.of<BlockStateProvider>(context,listen: false);
    log(blockProvider.areAllBlocksConnected().toString());
     if (!blockProvider.areAllBlocksConnected()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: AnimatedSnackBarContent(
            message: "Please connect all the blocks first",
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
     }
    String res = "";
    var activeBlocks = blockProvider.activeBlocks;
    for(var rootBlock in activeBlocks){
      
      var currentRoot = rootBlock;
      res+=currentRoot.code;
      while(currentRoot.child != null)
      {
        res+= currentRoot.child!.code;
        currentRoot = currentRoot.child!;
      }
    }
    eval(res);
  }
}

class AnimatedSnackBarContent extends StatelessWidget {
  final String message;

  const AnimatedSnackBarContent({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: -50.0, end: 0.0),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Opacity(
            opacity: 1 - (value / -50.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      message,
                      style: GoogleFonts.specialElite(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
