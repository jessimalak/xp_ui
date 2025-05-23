import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xp_ui/xp_ui.dart' hide TitleBarStyle;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions =
        const WindowOptions(titleBarStyle: TitleBarStyle.hidden);
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
  final XpTabViewController _tabViewController = XpTabViewController(length: 2);

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
    return XpWindow(
      titleBar: TitleBar.window(
        'Example',
        showHelpButton: true,
        onHelpButtonPressed: () {
          showXpDialog(
              context: context,
              builder: (context) => const XpAlertDialog(
                    title: 'About',
                    content: Text('Xp_ui for flutter\nBy Malak;'),
                    alerType: AlertType.info,
                  ));
        },
      ),
      sidebar: Sidebar(
          builder: (context, controller) => SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    SidebarExpandableItem(title: Text('System Tasks'), children: [Text('data')])
                  ],
                ),
              ),
          minWidth: 200,
          shownByDefault: true),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                Button(
                  onPressed: () {
                    showXpDialog(
                        context: context,
                        builder: (context) => XpAlertDialog(
                              title: 'Simple Alert',
                              content:
                                  const Text('This is a simple alert dialog'),
                              actions: [
                                Button(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Button(
                                  child: const Text('Accept'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                  },
                  child: const Text('show simple alert'),
                ),
                Button(
                  onPressed: () {
                    showXpDialog(
                        context: context,
                        builder: (context) => XpAlertDialog(
                              title: 'Warning Alert',
                              alerType: AlertType.warning,
                              content:
                                  const Text('This is a warning alert dialog'),
                              actions: [
                                Button(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Button(
                                  child: const Text('Accept'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                  },
                  child: const Text('show warning alert'),
                ),
                Button(
                  onPressed: () {
                    showXpDialog(
                        context: context,
                        builder: (context) => XpAlertDialog(
                              title: 'Error Alert',
                              alerType: AlertType.error,
                              content:
                                  const Text('This is an error alert dialog'),
                              actions: [
                                Button(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Button(
                                  child: const Text('Accept'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                  },
                  child: const Text('show error alert'),
                ),
                Button(
                  onPressed: () {
                    showXpDialog(
                        context: context,
                        builder: (context) => XpAlertDialog(
                              title: 'Info Alert',
                              alerType: AlertType.info,
                              content:
                                  const Text('This is an info alert dialog'),
                              actions: [
                                Button(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Button(
                                  child: const Text('Accept'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                  },
                  child: const Text('show info alert'),
                ),
                Button(
                  onPressed: () {
                    showXpDialog(
                        context: context,
                        builder: (context) => XpAlertDialog(
                              title: 'Question Alert',
                              alerType: AlertType.question,
                              content: const Text(
                                  'This is an question alert dialog'),
                              actions: [
                                Button(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Button(
                                  child: const Text('Accept'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                  },
                  child: const Text('show question alert'),
                ),
                const Button(
                  onPressed: null,
                  child: Text('Disabled button'),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text('$_counter%'),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  XpCheckbox(
                    value: true,
                    label: 'checkbox label',
                  ),
                  XpCheckbox(
                    value: false,
                    label: 'checkbox label',
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: 64,
                          itemBuilder: (context, i) => Text('Item $i'))),
                  Expanded(
                    child: XpTabView(controller: _tabViewController, tabs: [
                      XpTab(label: 'label 1'),
                      XpTab(label: 'label 2')
                    ], children: [
                      Text('contenido'),
                      Text('contenido')
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
