import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scratch_clone/block_model.dart';
import 'package:scratch_clone/block_widget.dart';

class DraggableBlock extends StatelessWidget {
  final BlockModel blockModel;
  final Function(Offset newPosition) onDragUpdate;
  final Function(Offset newPosition) onAccept;
  final Color color;
  const DraggableBlock(
      {super.key, required this.blockModel, required this.onDragUpdate, required this.onAccept, required this.color});

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();
    return DragTarget<BlockModel>(
      key: key,
      builder: (context, candidateData, rejectedData) {
        return Draggable(
          data: blockModel,
          feedback: BlockWidget(blockModel: blockModel, color: color),
          childWhenDragging: BlockWidget(blockModel: blockModel,  color: color.withOpacity(0.5)),
          child: BlockWidget(blockModel: blockModel, color: color),
          onDragEnd: (details){
            onDragUpdate(details.offset);
          },
        );
      },
      onAcceptWithDetails: (details){
        RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
        Offset localOffset = renderBox.localToGlobal(Offset.zero);
        Size size = renderBox.size;
        
        log("${details.data.blockType} block accepted at $localOffset with size $size");
        onAccept(localOffset-const Offset(100, 100));
      },
    );
  }
}
