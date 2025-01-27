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
  Color color;
  Offset? position;
  ConnectionState state;
  BlockType blockType;
  double width;
  double height;
  Source source;
  BlockModel({
    required this.color,
    this.position,
    required this.state,
    required this.blockType,
    required this.width,
    required this.height,
    required this.source,
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
      other.source == source;
  }

  @override
  int get hashCode {
    return color.hashCode ^
      position.hashCode ^
      state.hashCode ^
      blockType.hashCode ^
      width.hashCode ^
      height.hashCode ^
      source.hashCode;
  }

  BlockModel copyWith({
    Color? color,
    Offset? position,
    ConnectionState? state,
    BlockType? blockType,
    double? width,
    double? height,
    Source? source,
  }) {
    return BlockModel(
      color: color ?? this.color,
      position: position ?? this.position,
      state: state ?? this.state,
      blockType: blockType ?? this.blockType,
      width: width ?? this.width,
      height: height ?? this.height,
      source: source ?? this.source,
    );
  }

  
}
