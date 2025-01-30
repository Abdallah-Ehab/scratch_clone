import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:scratch_clone/block_model.dart';
import 'package:scratch_clone/block_model.dart' as custom;

class BlockStateProvider extends ChangeNotifier {
  late BlockModel _selectedBlock;
  late BlockModel _parentBlock;
  List<BlockModel> activeBlocks = <BlockModel>[
    BlockModel
    (code: "if(1 == 2)",
      color: Colors.red,
      source: Source.workSpace,
      position: const Offset(100, 100),
      width: 100.0,
      height: 100.0,
      blockType: BlockType.input,
      state: custom.ConnectionState.disconnected,
      blockId: 1,
    ),
  ];
  BlockModel get selectedBlock => _selectedBlock;
  set selectedBlock(BlockModel block) {
    _selectedBlock = block;
    notifyListeners();
  }

  BlockModel get parentBlock => _parentBlock;
  set parentBlock(BlockModel block) {
    _parentBlock = block;
    notifyListeners();
  }

  void connectBlock(BlockModel parent, BlockModel child) {
  
  parent.child = BlockModel(
    code: child.code,
    color: child.color,
    source: child.source,
    position: parent.position! + Offset(0, parent.height - 75),
    width: child.width,
    height: child.height,
    blockType: child.blockType,
    state: custom.ConnectionState.connected,
    blockId: child.blockId,
    parent: parent
  );

  activeBlocks.remove(child);
  notifyListeners();
}

void removeFromactive(BlockModel block){
  activeBlocks.remove(block);
  notifyListeners();
}

  void disconnectBlock(BlockModel selectedBlock) {
    selectedBlock.parent!.child = null;
    selectedBlock.state = custom.ConnectionState.disconnected;
    activeBlocks.add(selectedBlock);
    notifyListeners();
  }

  void updateParentBlock(BlockModel block) {
    parentBlock.child = block;
    notifyListeners();
  }

  void updateActiveBlocks(BlockModel block) {
    activeBlocks.add(block);
    notifyListeners();
  }

  void updateBlockPosition(BlockModel block, Offset localOffset) {
   block.position = localOffset; 
   log("block number ${block.blockId} is at position ${block.position}");
   notifyListeners();
  log("block number ${block.blockId} is at position ${block.position}");
    notifyListeners();
}


}

 

  
  

