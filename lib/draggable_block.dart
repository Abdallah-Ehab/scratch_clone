import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scratch_clone/block_model.dart';
import 'package:scratch_clone/block_state_provider.dart';
import 'package:scratch_clone/block_widget.dart';
import 'package:scratch_clone/block_model.dart' as custom;


class DraggableBlock extends StatelessWidget {
  final BlockModel blockModel;
  final Color color;
  const DraggableBlock(
      {super.key, required this.blockModel, required this.color});

  @override
  Widget build(BuildContext context) {
    final blockProvider = Provider.of<BlockStateProvider>(context);
    GlobalKey key = GlobalKey();
    return DragTarget<BlockModel>(
      key: key,
      builder: (context, candidateData, rejectedData) {
        return Draggable(
          data: blockModel,
          feedback: BlockWidget(blockModel: blockModel, color: color),
          childWhenDragging: BlockWidget(
              blockModel: blockModel, color: color.withOpacity(0.5)),
          child: BlockWidget(blockModel: blockModel, color: color),
          onDragEnd: (details) {
            var draggedBlock = blockProvider.selectedBlock;
            blockProvider.updateBlockPosition(draggedBlock, details.offset);
          },
          onDragStarted: () {
            blockProvider.selectedBlock = blockModel;
            if(blockModel.state == custom.ConnectionState.connected){
              blockProvider.disconnectBlock(blockProvider.selectedBlock);
            }
          },
        );
      },
      onAcceptWithDetails: (details) {
        
        RenderBox renderBox =  key.currentContext!.findRenderObject() as RenderBox;
        Size size = renderBox.size;

        var parentBlock = blockModel;
        var childBlock = details.data;
        log("block number ${childBlock.blockId} is dropped on block number ${parentBlock.blockId}");
        blockProvider.connectBlock(parentBlock, childBlock);
        blockProvider.updateBlockPosition(
          childBlock,
          parentBlock.position! + Offset(0, size.height - 75),
        );
      },
    );
  }
}
