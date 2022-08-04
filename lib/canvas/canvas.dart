import 'package:canvasproblem/canvas/export.dart';
import 'package:canvasproblem/extensions/export.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CanvasArea extends ConsumerStatefulWidget {
  final Color backgroundColor;
  final Size size;

  const CanvasArea({
    Key? key,
    this.backgroundColor = const Color(0xffe5e5e5),
    required this.size,
  }) : super(key: key);

  @override
  ConsumerState<CanvasArea> createState() => _CanvasState();
}

class _CanvasState extends ConsumerState<CanvasArea> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final canvasState = ref.watch(canvasSP);
      final canvasStateNotifier = ref.read(canvasSP.notifier);
      canvasStateNotifier.setCanvasSize(widget.size);

      // TODO: This listener should be removed in dispose()
      RawKeyboard.instance.addListener((event) {
        if (event is RawKeyDownEvent) {
          if (event.isShiftPressed) {
            if (event.isKeyPressed(LogicalKeyboardKey.keyR)) {
              canvasStateNotifier.setScale(1.0);
            }
          }
        }
        if (!canvasState.tertiary &&
            event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.space) {
          canvasStateNotifier.onTertiaryTapDown();
        } else if (canvasState.tertiary &&
            event is RawKeyUpEvent &&
            event.logicalKey == LogicalKeyboardKey.space) {
          canvasStateNotifier.onTertiaryTapUp();
        }
        if (event.isControlPressed) {
          if (event.isKeyPressed(LogicalKeyboardKey.equal)) {
            canvasStateNotifier.updateScaleFromDouble(0.1);
          } else if (event.isKeyPressed(LogicalKeyboardKey.minus)) {
            canvasStateNotifier.updateScaleFromDouble(-0.1);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final canvasStateNotifier = ref.read(canvasSP.notifier);

    final canvasTertiary = ref.watch(
      canvasSP.select((value) => value.tertiary),
    );

    final canvasComponentsWidgets = ref
        .watch(
          canvasSP.select((value) => value.components),
        )
        .mapIndexed(
          (element, index) => CanvasComponent(
            id: element.id,
            index: index,
          ),
        );

    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: GestureDetector(
        onTertiaryTapDown: (_) => canvasStateNotifier.onTertiaryTapDown(),
        onTertiaryTapUp: (_) => canvasStateNotifier.onTertiaryTapUp(),
        onScaleStart: canvasStateNotifier.onCanvasScaleStart,
        onScaleUpdate: canvasStateNotifier.onCanvasScaleUpdate,
        onScaleEnd: canvasStateNotifier.onCanvasScaleEnd,
        child: RepaintBoundary(
          child: Listener(
            onPointerMove: (PointerMoveEvent event) {
              if ((event.buttons == kTertiaryButton) && !canvasTertiary) {
                canvasStateNotifier.updateTertiary(true);
              }
            },
            onPointerUp: (_) {
              if (canvasTertiary) {
                canvasStateNotifier.updateTertiary(false);
              }
            },
            onPointerSignal: canvasStateNotifier.onCanvasPointerSignal,
            child: Container(
              color: widget.backgroundColor,
              child: ClipRect(
                child: Stack(
                  children: canvasComponentsWidgets.toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
