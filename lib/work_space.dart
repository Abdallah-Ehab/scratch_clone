import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scratch_clone/block_model.dart';
import 'package:scratch_clone/block_model.dart' as custom;
import 'package:scratch_clone/draggable_block.dart';

class WorkSpace extends StatefulWidget {
  const WorkSpace({super.key});

  @override
  State<WorkSpace> createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
  final List<BlockModel> activeBlocks = <BlockModel>[
    BlockModel(
      color: Colors.red,
      source: Source.workSpace,
      position: const Offset(100, 100),
      width: 100.0,
      height: 100.0,
      blockType: BlockType.input,
      state: custom.ConnectionState.disconnected,
    ),
  ];
  final List<BlockModel> connectedBlocks = <BlockModel>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: DragTarget<BlockModel>(
        builder: (context, candidateData, rejectedData) {
          return Stack(
            children: [
              // Render each active block
              ...activeBlocks.map(
                (block) => Positioned(
                  top: block.position!.dy,
                  left: block.position!.dx,
                  child: DraggableBlock(
                    color: block.color,
                    blockModel: block,
                    onDragUpdate: (newPosition) {
                      setState(() {
                        block.position = newPosition;
                      });
                    },
                    onAccept: (Offset newPosition) {
                      setState(() {
                        block.position = newPosition;
                        connectedBlocks.add(block);
                        log("dragged block color is ${block.color} and drag target block color is ${connectedBlocks[0].color}");
                        log("Connected Blocks: $connectedBlocks");
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        },
        onWillAcceptWithDetails: (details) {
          return true;
        },
        onAcceptWithDetails: (details) {
          setState(() {
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final Offset localOffset = renderBox.globalToLocal(details.offset);

            if (details.data.source == Source.storage) {
              activeBlocks.add(BlockModel(
                color: details.data.color,
                position: localOffset,
                width: details.data.width,
                height: details.data.height,
                blockType: details.data.blockType,
                state: details.data.state,
                source: Source.workSpace,
              ));
              log("Active Blocks: $activeBlocks");
            }else{
              int activeBlockIndex = activeBlocks.indexWhere((block)=> block == details.data);
              if(activeBlockIndex != -1){
                activeBlocks[activeBlockIndex].position = localOffset.translate(-details.data.width/2, -details.data.height/2);
              }
            }
          });
        },
      ),
    );
  }
}
