import 'package:canvasproblem/canvas/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/export.dart';

class CanvasComponent extends ConsumerStatefulWidget {
  final Offset startingOffset;
  final String id;
  final int index;
  final Size size;
  final Widget child;

  const CanvasComponent({
    Key? key,
    this.startingOffset = Offset.zero,
    required this.id,
    required this.child,
    required this.index,
    this.size = const Size(200, 100),
  }) : super(key: key);

  @override
  ConsumerState<CanvasComponent> createState() => _CanvasComponentState();
}

class _CanvasComponentState extends ConsumerState<CanvasComponent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // set component position
      final List<CanvasComponentData> components = ref.watch(
        canvasSP.select((value) => value.components),
      );

      final CanvasComponentData componentState = components[widget.index];

      if (componentState.position == Offset.zero) {
        ref.read(canvasSP.notifier).updateComponentPosition(
              widget.index,
              (componentState.position +
                  widget.startingOffset -
                  componentState.position),
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double canvasScale = ref.watch(
      canvasSP.select((value) => value.scale),
    );
    final Offset canvasPosition = ref.watch(
      canvasSP.select((value) => value.position),
    );
    final canvasStateNotifier = ref.read(canvasSP.notifier);

    final CanvasComponentData componentState = ref.watch(
      canvasSP.select((value) => value.components[widget.index]),
    );

    return Positioned(
      left: canvasScale * componentState.position.dx + canvasPosition.dx,
      top: canvasScale * componentState.position.dy + canvasPosition.dy - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onScaleStart: (details) => canvasStateNotifier
                .onComponentScaleStart(widget.index, details),
            onScaleUpdate: (details) => canvasStateNotifier
                .onComponentScaleUpdate(widget.index, details),
            child: SizedBox(
              height: 20,
              width: componentState.size.width * canvasScale,
              child: Text(
                componentState.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Transform.scale(
            alignment: Alignment.topLeft,
            scale: canvasScale,
            child: SizedBox(
              width: componentState.size.width,
              height: componentState.size.height,
              child: ClipRect(
                child: CanvasPage(
                  componentID: widget.id,
                  data: null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
