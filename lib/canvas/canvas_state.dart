// ignore_for_file: unused_local_variable

import 'package:canvasproblem/canvas/example_data.dart';
import 'package:canvasproblem/extensions/offset.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/component.dart';

class CanvasState extends ChangeNotifier {
  Offset position = const Offset(250, 250);
  double scale = 1.0;
  bool tertiary = false;
  double transformScale = 1.0;
  List<CanvasComponentData> components = [
    bankExampleComponent.copyWith(id: const Uuid().v4())
  ];
  GlobalKey gKey = GlobalKey();
  GlobalKey canvasGlobalKey = GlobalKey();
  Size size = Size.zero;
  double _baseScale = 1.0;
  Offset _basePosition = Offset.zero;
  Offset lastFocalPoint = Offset.zero;
  Offset transformPosition = Offset.zero;
  final double _mouseScaleSpeed = 0.9;

  final double _maxScale = 200.0;

  final double _minScale = 0.01;

/* Overflow */
  /// returns nearest [CanvasComponentData] in `components` on horizontal direction
  CanvasComponentData getNearestHorizontalComponent() {
    CanvasComponentData nc = components.first;
    for (var i = 0; i < components.length; i++) {
      if (components[i].position.dx < nc.position.dx) {
        nc = components[i];
      }
    }
    return nc;
  }

  /// returns Farthest [CanvasComponentData] in `components` on horizontal direction
  CanvasComponentData getFarthestHorizontalComponent() {
    CanvasComponentData fc = components.first;
    for (var i = 0; i < components.length; i++) {
      if (components[i].position.dx > fc.position.dx) {
        fc = components[i];
      }
    }
    return fc;
  }

  /// returns Farthest [CanvasComponentData] in `components` on Vertical direction
  CanvasComponentData getFarthestVerticalComponent() {
    CanvasComponentData fc = components.first;
    for (var i = 0; i < components.length; i++) {
      if (components[i].position.dy > fc.position.dy) {
        fc = components[i];
      }
    }
    return fc;
  }

  /// returns nearest [CanvasComponentData] in `components` on Vertical direction
  CanvasComponentData getNearestVerticalComponent() {
    CanvasComponentData nc = components.first;
    for (var i = 0; i < components.length; i++) {
      if (components[i].position.dy < nc.position.dy) {
        nc = components[i];
      }
    }
    return nc;
  }

  /// checks if component `c` is overflowing on `axis` in `direction`
  bool isOverflowing(CanvasComponentData c, String axis, String direction) {
    final Offset cp = c.position.scale(scale, scale);
    final double cx = cp.dx + position.dx;
    final double cy = cp.dy + position.dy;
    final cw = c.size.width * scale;
    final ch = c.size.height * scale;

    if (axis == "x") {
      if (cx < 0 && direction == "nearest") {
        return true;
      } else if ((cx + cw) > size.width && direction == "farthest") {
        return true;
      }
    }
    if (axis == "y") {
      if (cy < 0 && direction == "nearest") {
        return true;
      } else if ((cy + ch) > size.height && direction == "farthest") {
        return true;
      }
    }
    return false;
  }

  /// scrolls the overflow on vertical direction
  void scrollVerticalOverflow(Offset delta) {
    if (delta.dy == 0 || components.isEmpty) return;

    final CanvasComponentData nearestComponent = getNearestVerticalComponent();
    final CanvasComponentData farthestComponent =
        getFarthestVerticalComponent();
    double spacingNearest = 0,
        spacingFarthest = 0,
        nearestPointDistance = 0,
        farthestPointDistance = 0;
    bool isNearestOverflowing = isOverflowing(nearestComponent, "y", "nearest");
    bool isFarthestOverflowing =
        isOverflowing(farthestComponent, "y", "farthest");
    final double nearestPointCoordinates =
        (nearestComponent.position.dy * scale) + position.dy;
    final double farthestPointCoordinates =
        (farthestComponent.position.dy * scale) + position.dy;
    if (isNearestOverflowing) {
      nearestPointDistance = nearestPointCoordinates.abs();
    }
    if (isFarthestOverflowing ||
        farthestPointDistance == nearestPointDistance) {
      farthestPointDistance = farthestPointCoordinates +
          (farthestComponent.size.height * scale) -
          size.height;
    }
    final double totalSize =
        nearestPointDistance + size.height + farthestPointDistance;
    if (isNearestOverflowing) {
      spacingNearest = nearestPointDistance / totalSize * size.height;
    }
    if (isFarthestOverflowing) {
      spacingFarthest = farthestPointDistance / totalSize * size.height;
    }

    final toScroll = ((delta.dy.abs()) / size.height) * totalSize;

    updatePosition(
      Offset(0, delta.dy < 0 ? toScroll : -toScroll),
    );
  }

  /// scrolls the overflow on horizontal direction
  void scrollHorizontalOverflow(Offset delta) {
    if (delta.dx == 0 || components.isEmpty) return;
    final CanvasComponentData nearestComponent =
        getNearestHorizontalComponent();
    final CanvasComponentData farthestComponent =
        getFarthestHorizontalComponent();
    double spacingNearest = 0,
        spacingFarthest = 0,
        nearestPointDistance = 0,
        farthestPointDistance = 0;

    bool isNearestOverflowing = isOverflowing(nearestComponent, "x", "nearest");
    bool isFarthestOverflowing =
        isOverflowing(farthestComponent, "x", "farthest");
    final double nearestPointCoordinates =
        (nearestComponent.position.dx * scale) + position.dx;
    final double farthestPointCoordinates =
        (farthestComponent.position.dx * scale) + position.dx;
    if (isNearestOverflowing) {
      nearestPointDistance = nearestPointCoordinates.abs();
    }
    if (isFarthestOverflowing ||
        farthestPointDistance == nearestPointDistance) {
      farthestPointDistance = farthestPointCoordinates +
          (farthestComponent.size.width * scale) -
          size.width;
    }
    final double totalSize =
        nearestPointDistance + size.width + farthestPointDistance;
    if (isNearestOverflowing) {
      spacingNearest = nearestPointDistance / totalSize * size.width;
    }
    if (isFarthestOverflowing) {
      spacingFarthest = farthestPointDistance / totalSize * size.width;
    }

    final toScroll = ((delta.dx.abs()) / size.width) * totalSize;

    updatePosition(
      Offset(delta.dx < 0 ? toScroll : -toScroll, 0),
    );
  }

/* Tertiary */

  /// sets `tertiary` to `condition`
  void updateTertiary(bool condition) {
    tertiary = condition;
    notifyListeners();
  }

  /// handles the [TapDownDetails] event
  void onTertiaryTapDown() {
    tertiary = true;
    notifyListeners();
  }

  /// handles the [TapUpDetails] event
  void onTertiaryTapUp() {
    tertiary = false;
    notifyListeners();
  }

  /// sets canvas position from tertiary event
  void tertiaryPosition(Offset focalPointDelta) {
    setPosition(position + focalPointDelta);
    notifyListeners();
  }

/* Components */

  /// set some values on the starting of the component scale to calculate its local position later;
  void onComponentScaleStart(int i, ScaleStartDetails details) {
    components[i] = components[i].copyWith(
      startFocalPosition: details.localFocalPoint,
      startComponentPosition: components[i].position,
    );

    notifyListeners();
  }

  /// update the component position using the values set by [onComponentScaleStart]
  void onComponentScaleUpdate(int i, ScaleUpdateDetails details) {
    updateComponentPosition(
      i,
      (components[i].startComponentPosition +
          (details.localFocalPoint - components[i].startFocalPosition) / scale),
    );
  }

  int? getComponentIndex(String id) {
    final search = components.indexWhere((element) => element.id == id);
    return search == -1 ? null : search;
  }

  CanvasComponentData getComponent({String? id, int? index}) {
    return index != null
        ? components[index]
        : components.firstWhere((element) => element.id == id);
  }

  /// updates [String] label
  void updateComponentLabel(int i, String label) {
    components[i] = components[i].copyWith(label: label);
    notifyListeners();
  }

  /// adds component to `components`
  void addComponent(CanvasComponentData component) {
    components = [...components, component];
    notifyListeners();
  }

  /// update component position using the [int] index which is the position of the component in the list
  void updateComponentPosition(int index, Offset newComponentPosition) {
    components[index] =
        components[index].copyWith(position: newComponentPosition);
    notifyListeners();
  }

  void updateComponentNode(Map<String, dynamic> node) {
    final index = getComponentIndex(node['id']);
    if (index == null) {
      throw NullThrownError();
    }
    components[index] = components[index].copyWith(node: node);
    notifyListeners();
  }

  /// update component size using the [int] index which is the position of the component in the list
  void updateComponentSize(int index, Size size) {
    components[index] = components[index].copyWith(size: size);
    notifyListeners();
  }

/* Canvas */

  /// used to update the canvas with last values that got set by [onCanvasScaleStart]
  void updateCanvasModelWithLastValues() {
    setPosition((_basePosition * transformScale) + transformPosition);
    setScale(transformScale * _baseScale);
    notifyListeners();
  }

  /// handles any pointer signal on the canvas
  void onCanvasPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent &&
        (RawKeyboard.instance.keysPressed
            .contains(LogicalKeyboardKey.shiftLeft))) {
      scrollHorizontalOverflow(event.scrollDelta.inverse);
    } else if (event is PointerScrollEvent &&
        (!RawKeyboard.instance.keysPressed
                .contains(LogicalKeyboardKey.shiftLeft) &&
            !RawKeyboard.instance.keysPressed
                .contains(LogicalKeyboardKey.controlLeft))) {
      scrollVerticalOverflow(event.scrollDelta);
    }
    if (event is PointerScrollEvent &&
        (RawKeyboard.instance.keysPressed
            .contains(LogicalKeyboardKey.controlLeft))) {
      double scaleChange = event.scrollDelta.dy < 0
          ? (1 / _mouseScaleSpeed)
          : (_mouseScaleSpeed);

      scaleChange = keepScaleInBounds(scaleChange, scale);

      if (scaleChange == 0.0) return;

      double previousScale = scale;

      updateScale(scaleChange);

      var focalPoint = (event.localPosition - position);
      var focalPointScaled = focalPoint * (scale / previousScale);

      updatePosition(focalPoint - focalPointScaled);
    }
    notifyListeners();
  }

  /// resets `scale` to `1.0` and position to `Offset.zero`
  void resetCanvasView() {
    setPosition(Offset.zero);
    setScale(1.0);
  }

  /// adds `offset` to the position of the canvas(origin)
  void updatePosition(Offset offset) {
    position += offset;
    notifyListeners();
  }

  /// sets `position` as `position`
  void setPosition(Offset nPosition) {
    position = nPosition;
    notifyListeners();
  }

  /// sets canvas size to `size`
  void setCanvasSize(Size nSize) {
    size = nSize;
    notifyListeners();
  }

/* Scale */

  /// updates scale to `scale = scale * scale`
  void updateScale(double nScale) {
    setScale(scale * nScale);
  }

  /// updates scale to `scale` and keeps it in bound of `_maxScale` and `_minScale`
  void updateScaleFromDouble(double newScale) {
    if (scale < 0) {
      setScale(scale - newScale.abs());
    } else {
      setScale(scale + newScale);
    }
  }

  /// sets `scale` to `scale`
  void setScale(double nScale) {
    scale = nScale.clamp(_minScale, _maxScale);
    notifyListeners();
  }

  /// increases `scale` value by `0.1` taking `_maxScale` in consideration
  void zoomIn() {
    setScale(scale + 0.1);
  }

  /// decreases `scale` value by `0.1` taking `_minScale` in consideration
  void zoomOut() {
    setScale(scale - 0.1);
  }

  /// keeps scale in bound of `_maxScale` and `_minScale`
  double keepScaleInBounds(double scale, double canvasScale) {
    double scaleResult = scale;
    if (scale * canvasScale <= _minScale) {
      scaleResult = _minScale / canvasScale;
    }
    if (scale * canvasScale >= _maxScale) {
      scaleResult = _maxScale / canvasScale;
    }
    return scaleResult;
  }

  /// handles the [onScaleStart] event
  void onCanvasScaleStart(ScaleStartDetails details) {
    _baseScale = scale;
    _basePosition = position;
    lastFocalPoint = details.focalPoint;
    notifyListeners();
  }

  /// handles the [onScaleUpdate] event
  void onCanvasScaleUpdate(ScaleUpdateDetails details) {
    updateCanvasModelWithLastValues();

    transformPosition += details.focalPoint - lastFocalPoint;
    transformScale = keepScaleInBounds(details.scale, _baseScale);

    lastFocalPoint = details.focalPoint;

    transformPosition += details.focalPointDelta;
    notifyListeners();
  }

  /// handles the [onScaleEnd] event
  void onCanvasScaleEnd(ScaleEndDetails details) {
    transformPosition = Offset.zero;
    transformScale = 1.0;
    notifyListeners();
  }
}

final canvasSP = ChangeNotifierProvider<CanvasState>((ref) {
  return CanvasState();
});
