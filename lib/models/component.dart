import 'package:flutter/material.dart';

class CanvasComponentData {
  String id;
  String label;
  Offset position;
  Offset startComponentPosition;
  Offset startFocalPosition;
  Size size;
  Widget child;
  GlobalKey gKey;
  UniqueKey uKey;
  Map<String, dynamic> node;
  CanvasComponentData({
    required this.id,
    required this.label,
    this.position = Offset.zero,
    this.startComponentPosition = Offset.zero,
    this.startFocalPosition = Offset.zero,
    required this.size,
    required this.child,
    required this.gKey,
    required this.uKey,
    this.node = const {},
  });

  CanvasComponentData copyWith({
    String? id,
    String? label,
    Offset? position,
    Offset? startComponentPosition,
    Offset? startFocalPosition,
    Size? size,
    Widget? child,
    GlobalKey? gKey,
    UniqueKey? uKey,
    Map<String, dynamic>? node,
  }) {
    return CanvasComponentData(
      id: id ?? this.id,
      label: label ?? this.label,
      position: position ?? this.position,
      startComponentPosition:
          startComponentPosition ?? this.startComponentPosition,
      startFocalPosition: startFocalPosition ?? this.startFocalPosition,
      size: size ?? this.size,
      child: child ?? this.child,
      gKey: gKey ?? this.gKey,
      uKey: uKey ?? this.uKey,
      node: node ?? this.node,
    );
  }
}
