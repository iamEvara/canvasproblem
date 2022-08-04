import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

import '../models/export.dart';
import 'export.dart';

class CanvasPage extends StatefulWidget {
  const CanvasPage({
    Key? key,
    required this.data,
    required this.componentID,
  }) : super(key: key);
  final JsonWidgetData? data;
  final String componentID;
  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  JsonWidgetData? data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  void didUpdateWidget(CanvasPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data.toString() != widget.data.toString()) {
      data = widget.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        final JsonWidgetData? data = JsonWidgetData.fromDynamic(
          ref.watch(
            canvasSP.select((value) => value.components
                .firstWhere((CanvasComponentData element) =>
                    element.id == widget.componentID)
                .node),
          ),
        );
        return data == null
            ? const SizedBox.shrink()
            : data.build(
                context: context,
                childBuilder: null,
              );
      }),
    );
  }
}
