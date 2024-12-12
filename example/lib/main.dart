import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xp_ui/xp_ui.dart' hide TitleBarStyle;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(titleBarStyle: TitleBarStyle.hidden);
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return XpApp(
      title: 'Flutter Demo',
      theme: XpThemeData(),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late final Timer _timer;

  void _incrementCounter() {
    if (_counter == 100) {
      _counter = 0;
    }
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 250), (time) {
      _incrementCounter();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const TitleBar.window(
            'Example',
            showHelpButton: true,
          ),
          const Text(
            'You have pushed the button this many times:',
          ),
          Text('$_counter'),
          Button(
            onPressed: () {
              showXpDialog(context: context, builder: (context) => const XpAlertDialog(title: 'alerta'));
            },
            child: const Text('Xp button'),
          ),
          const SizedBox(
            height: 16,
          ),
          const Button(
            onPressed: null,
            child: Text('Xp button'),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 600,
            child: ProgressBar(
              value: _counter.toDouble(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            width: 600,
            child: ProgressBar(),
          ),
          const SizedBox(
            height: 16,
          ),
          const Textbox(
            labelWidget: Text('Label top widget'),
          ),
          const SizedBox(
            height: 16,
          ),
          const Textbox(
            labelText: 'Label left Text',
            labelPosition: TextboxLabelPosition.left,
          ),
          Expanded(child: ListView.builder(itemCount: 64, itemBuilder: (context, i) => Text('Item $i')))
        ],
      ),
    );
  }
}
