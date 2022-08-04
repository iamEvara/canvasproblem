import 'package:canvasproblem/canvas/export.dart';
import 'package:canvasproblem/extensions/export.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class CanvasArea extends ConsumerStatefulWidget {
  const CanvasArea({
    Key? key,
    this.backgroundColor = const Color(0xffe5e5e5),
    required this.size,
  }) : super(key: key);
  final Color backgroundColor;
  final Size size;

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

  final UniqueKey uKey = UniqueKey();
  final GlobalKey gKey = GlobalKey();

  final Uuid uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    final canvasStateNotifier = ref.read(canvasSP.notifier);

    final canvasTertiary =
        ref.watch(canvasSP.select((value) => value.tertiary));
    final canvasGlobalKey =
        ref.watch(canvasSP.select((value) => value.canvasGlobalKey));
    final canvasComponentsWidgets = ref.watch(
      canvasSP.select(
        (value) => value.components.mapIndexed(
          (element, index) => CanvasComponent(
            uKey: uKey,
            id: element.id,
            index: index,
            child: element.child,
          ),
        ),
      ),
    );

    return SizedBox(
      key: gKey,
      height: widget.size.height,
      width: widget.size.width,
      child: GestureDetector(
        onTertiaryTapDown: (details) {
          canvasStateNotifier.onTertiaryTapDown();
        },
        onTertiaryTapUp: (_) {
          canvasStateNotifier.onTertiaryTapUp();
        },
        onScaleStart: (details) =>
            {canvasStateNotifier.onCanvasScaleStart(details)},
        onScaleUpdate: (details) {
          canvasStateNotifier.onCanvasScaleUpdate(
            details,
          );
        },
        onScaleEnd: (details) {
          canvasStateNotifier.onCanvasScaleEnd(details);
        },
        child: RepaintBoundary(
          key: canvasGlobalKey,
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
            onPointerSignal: (PointerSignalEvent event) =>
                canvasStateNotifier.onCanvasPointerSignal(event),
            child: Container(
              color: widget.backgroundColor,
              child: ClipRect(
                child: Stack(
                  children: [...canvasComponentsWidgets],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
