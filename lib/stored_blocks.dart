import 'package:flutter/material.dart';
import 'package:scratch_clone/block_model.dart';
import 'package:scratch_clone/draggable_block.dart';
import 'block_model.dart' as custom;

class StoredBlocks extends StatelessWidget {
   StoredBlocks({super.key});

  List<BlockModel> storedBlocks = [
         BlockModel(
          color: Colors.pink,
            source: Source.storage,
            position: const Offset(0, 0),
            width: 100.0,
            height: 100.0,
            blockType: BlockType.output,
            state: custom.ConnectionState.disconnected),
         BlockModel(
          color: Colors.amber,
            position: const Offset(0, 0),
             source: Source.storage,
            width: 100.0,
            height: 100.0,
            blockType: BlockType.output,
            state: custom.ConnectionState.disconnected),
         BlockModel(
          color: Colors.green,
            position: const Offset(0, 0),
             source: Source.storage,
            width: 100.0,
            height: 100.0,
            blockType: BlockType.output,
            state: custom.ConnectionState.disconnected),
      ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: storedBlocks.length,
      itemBuilder: (context, index) {
        return DraggableBlock(
          color: storedBlocks[index].color,
          blockModel: storedBlocks[index],
          onDragUpdate: (newPosition) {},
          onAccept: (newPosition) {},
        );
      },
    );
  }
}