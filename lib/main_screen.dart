import 'package:dart_eval/dart_eval.dart';
import 'package:flutter/material.dart';
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
    String res = "";
    var blockProvider = Provider.of<BlockStateProvider>(context,listen: false);
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
