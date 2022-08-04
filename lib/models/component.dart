import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'component.freezed.dart';

@freezed
class CanvasComponentData with _$CanvasComponentData {
  const factory CanvasComponentData({
    required String id,
    required String label,
    @Default(Offset.zero) Offset position,
    @Default(Offset.zero) Offset startComponentPosition,
    @Default(Offset.zero) Offset startFocalPosition,
    required Size size,
    @Default({}) Map<String, dynamic> node,
  }) = _CanvasComponentData;
}
