import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scratch_clone/block_model.dart';
import 'package:scratch_clone/block_state_provider.dart';
import 'package:scratch_clone/draggable_block.dart';

class WorkSpace extends StatefulWidget {
  const WorkSpace({super.key});

  @override
  State<WorkSpace> createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
  @override
  Widget build(BuildContext context) {
    final blockProvider = Provider.of<BlockStateProvider>(context);
    return Container(
      color: Colors.blue,
      child: DragTarget<BlockModel>(
          builder: (context, candidateData, rejectedData) {
        return Stack(
          children: renderNestedBlocks(context),
        );
      }, onWillAcceptWithDetails: (details) {
        return true;
      }, onAcceptWithDetails: (details) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset localOffset = renderBox.globalToLocal(details.offset);

        if (details.data.source == Source.storage) {
          blockProvider.updateActiveBlocks(BlockModel(
            code:details.data.code,
            color: details.data.color,
            position: localOffset,
            width: details.data.width,
            height: details.data.height,
            blockType: details.data.blockType,
            state: details.data.state,
            source: Source.workSpace,
            blockId: details.data.blockId,
          ));
          log("Active Blocks: ${blockProvider.activeBlocks}");
        } else {
          var activeBLocks = blockProvider.activeBlocks;
          var index = activeBLocks.indexWhere((block)=>block == blockProvider.selectedBlock);
          if(index != -1){
            blockProvider.updateBlockPosition(blockProvider.selectedBlock, localOffset);
          }
        }
      }),
    );
  }

  Widget renderBLocks(BuildContext context, BlockModel block) {

    return Positioned(
      top: block.position!.dy,
      left: block.position!.dx,
      child: DraggableBlock(
        color: block.color,
        blockModel: block,
      ),
    );
  }

List<Widget> renderNestedBlocks(BuildContext context) {
  List<Widget> blocksPositioned = [];
  var provider = Provider.of<BlockStateProvider>(context);
  
  for (var block in provider.activeBlocks) {
    blocksPositioned.addAll(traverseAndRender(context, block));
  }
  
  return blocksPositioned;
}

List<Widget> traverseAndRender(BuildContext context, BlockModel block) {
  List<Widget> blocks = [];
  
  blocks.add(renderBLocks(context, block));

  
  if (block.child != null) {
    log("block id: ${block.blockId} has position ${block.position} has child ${block.child!.blockId} and the child is at position ${block.child!.position}");
    blocks.addAll(traverseAndRender(context, block.child!));
  }

  return blocks;
}
}
