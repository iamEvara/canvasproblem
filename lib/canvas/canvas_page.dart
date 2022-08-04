import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

import '../models/export.dart';

class CanvasPage extends ConsumerStatefulWidget {
  final CanvasComponentData data;

  const CanvasPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  ConsumerState<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends ConsumerState<CanvasPage> {
  late final JsonWidgetData? data;
  Widget? _built;

  @override
  void initState() {
    super.initState();
    data = JsonWidgetData.fromDynamic(widget.data.node);
  }

  @override
  Widget build(BuildContext context) {
    _built ??= data?.build(context: context);

    return _built ?? const SizedBox.shrink();
  }
}
