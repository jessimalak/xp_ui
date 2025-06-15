import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart' hide ListTile;
import 'package:window_manager/window_manager.dart';
import 'package:xp_ui/xp_ui.dart';

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

  void _incrementCounter() {
    if (_counter == 100) {
      _counter = 0;
    }
    setState(() {
      _counter++;
    });
  }

  int? _option = 0;
  bool _firstCheck = false;
  bool _secondCheck = true;

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
      statusBar: StatusBar(
        rightChildren: const [Text('Slide 1'), Text('Data')],
        child: Text('Current progress $_counter%'),
      ),
      sidebar: Sidebar(
          builder: (context, controller) => SingleChildScrollView(
                controller: controller,
                child: const Column(
                  spacing: 8,
                  children: [
                    SidebarExpandableItem(
                        initiallyExpanded: true,
                        title: Text('Expandable item'),
                        children: [
                          ListTile(
                              label: Text('Documents'),
                              icon: SystemIcon(
                                  icon: XpSystemIcons.folderDocument)),
                          ListTile(
                              label: Text('Music'),
                              icon:
                                  SystemIcon(icon: XpSystemIcons.folderMusic)),
                          ListTile(
                              label: Text('My PC'),
                              icon: SystemIcon(icon: XpSystemIcons.computer))
                        ]),
                    SidebarExpandableItem(
                      initiallyExpanded: true,
                      title: Text('Details'),
                      children: [
                        Text(
                          'xp_ui package',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'By Jessimalak',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'With 🩵 for Flutter community',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    )
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
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Group(
                        spacing: 16,
                        label: const Text("Buttons and Alerts"),
                        children: [
                          Button(
                            onPressed: () {
                              showXpDialog(
                                  context: context,
                                  builder: (context) => XpAlertDialog(
                                        title: 'Simple Alert',
                                        content: const Text(
                                            'This is a simple alert dialog'),
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
                                        content: const Text(
                                            'This is a warning alert dialog'),
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
                                        content: const Text(
                                            'This is an error alert dialog'),
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
                                        content: const Text(
                                            'This is an info alert dialog'),
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
                      Group(
                        label: const Text('Checkbox'),
                        children: [
                          const XpCheckbox(
                            value: false,
                            label: 'checkbox disabled',
                          ),
                          XpCheckbox(
                            value: _firstCheck,
                            label: 'checkbox label',
                            onChanged: (value) {
                              setState(() {
                                _firstCheck = value;
                              });
                            },
                          ),
                          XpCheckbox(
                            value: _secondCheck,
                            label: 'checkbox label',
                            onChanged: (value) {
                              setState(() {
                                _secondCheck = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Group(label: const Text('Radio options'), children: [
                        RadioOptions(
                            selected: _option,
                            options: List.generate(
                                5,
                                (i) => RadioOption(
                                    enabled: i != 3,
                                    value: i,
                                    label: 'Option $i')),
                            onChanged: (value) {
                              setState(() => _option = value);
                            })
                      ])
                    ],
                  ),
                )),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
