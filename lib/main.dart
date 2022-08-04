/// ctrl + mouse cursor scroll = zoom in/out
/// mouse scroll up -> scroll up
/// mouse scroll down -> scroll down
/// shift + mouse scroll down -> scroll left
/// shift + mouse scroll up -> scroll right
/// ctrl + `+` zoom in
/// ctrl + `-` zoom out
/// middle mouse button hold => move
/// move component by holding on the title and moving it
import 'package:canvasproblem/canvas/export.dart';
import 'package:canvasproblem/canvas/example_data.dart';
import 'package:canvasproblem/extensions/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: true,
        title: 'Flutter Issue',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Example"),
        actions: [
          Consumer(builder: (context, ref, child) {
            final canvasStateNotifier = ref.read(canvasSP.notifier);
            return Row(
              children: [
                IconButton(
                  tooltip: "Zoom in",
                  onPressed: () => canvasStateNotifier.zoomIn(),
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  tooltip: "Reset View",
                  onPressed: () => canvasStateNotifier.resetCanvasView(),
                  icon: const Icon(Icons.restart_alt),
                ),
                IconButton(
                  tooltip: "Zoom out",
                  onPressed: () => canvasStateNotifier.zoomOut(),
                  icon: const Icon(Icons.remove),
                ),
              ],
            );
          })
        ],
      ),
      body: Center(
        child: CanvasArea(
          size: Size(
            context.width,
            context.height,
          ),
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        final canvasStateNotifier = ref.read(canvasSP.notifier);
        return FloatingActionButton(
          onPressed: () => canvasStateNotifier.addComponent(
            bankExampleComponent.copyWith(
              id: const Uuid().v4(),
              label: "New Frame",
            ),
          ),
          tooltip: 'Add Component',
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
