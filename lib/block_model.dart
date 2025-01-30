import 'package:flutter/material.dart';

enum BlockType{
  input,
  output,
  inputoutput
}
enum ConnectionState{
  connected,
  disconnected
}

enum Source{
  storage,
  workSpace
}

class BlockModel {
  int blockId;
  String code;
  Color color;
  Offset? position;
  ConnectionState state;
  BlockType blockType;
  double width;
  double height;
  Source source;
  BlockModel? child;
  BlockModel? parent;
  BlockModel({
    required this.blockId,
    required this.code,
    required this.color,
    this.position,
    required this.state,
    required this.blockType,
    required this.width,
    required this.height,
    required this.source,
    this.child,
    this.parent
  });

  @override
  bool operator ==(covariant BlockModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.color == color &&
      other.position == position &&
      other.state == state &&
      other.blockType == blockType &&
      other.width == width &&
      other.height == height &&
      other.source == source &&
      other.child == child &&
      other.parent == parent &&
      other.code == code;
  }

  @override
  int get hashCode {
    return color.hashCode ^
      position.hashCode ^
      state.hashCode ^
      blockType.hashCode ^
      width.hashCode ^
      height.hashCode ^
      source.hashCode ^ 
      child.hashCode ^
      parent.hashCode ^
      code.hashCode;
  }

  BlockModel copyWith({
    int? blockId,
    Color? color,
    Offset? position,
    ConnectionState? state,
    BlockType? blockType,
    double? width,
    double? height,
    Source? source,
    BlockModel? child,
    BlockModel? parent,
    String? code
  }) {
    return BlockModel(
      blockId: blockId ?? this.blockId,
      color: color ?? this.color,
      position: position ?? this.position,
      state: state ?? this.state,
      blockType: blockType ?? this.blockType,
      width: width ?? this.width,
      height: height ?? this.height,
      source: source ?? this.source,
      child: child ?? this.child,
      parent: parent ?? this.parent,
      code: code ?? ""
    );
  }

  
}
