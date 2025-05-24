# xp_ui

<img src="https://img.shields.io/badge/pub-0.0.1-lightblue?style=plastic" alt="pub" /> 

Windows Xp UI components for Flutter apps, inspired on [flutter95](https://pub.dev/packages/flutter95) and [fluent_ui](https://pub.dev/packages/fluent_ui)

## Screenshots


![screenshot of flutter app window usin xp_ui components](images/screenshot.png)

## Installation
Add this to your package's `pubspec.yaml` file:
```yaml
dependencies:
  xp_ui: ^0.0.1
```
To hide the native title bar and enable the maximize and minimize buttons install `window_manager` package. See [Documentation](https://pub.dev/packages/window_manager)

## Components

#### XpApp

Required to load all Xp styles, is compatible with standart flutter material Widgets.

```dart
 XpApp(
    title: 'Flutter Demo',
    theme: XpThemeData(),
    debugShowCheckedModeBanner: false,
    home: const MyHomePage(title: 'Flutter Demo Home Page'),
);
```
#### Window
`XpWindow` is the basic frame for a Xp-style layout. It supports a `Sidebar` on the left, and optional `TitleBar` at the top.

#### TitleBar
Provides the window title bar with customizable 4 action button.
> [!CAUTION]
> The [window_manager](https://pub.dev/packages/window_manager) package is required to work.

![Xp style window title bar](images/titlebar.png)
```dart
XpWindow(
    titlebar: TitleBar(
        'Example',
        showHelpButton: true,
        showMaximizeButton: true,
        showMinimizeButton: true,
        showCloseButton: true,
        onHelpButtonPressed: () {},
      )
)
```

#### Sidebar
Provides quick access to top-level collections of conent in your app.

![Xp style window sidebar](images/sidebar.png)
```dart
XpWindow(
    sidebar: Sidebar(
          builder: (context, controller) => SingleChildScrollView(
                controller: controller,
                child: const Column(
                  spacing: 8,
                  children: [
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
          shownByDefault: true)
)
```

#### Sidebar Expandable Item
Similar to Material's `ExpansionTitle` with the style of original Xp style expandable panels on window sidebar.

```dart
SidebarExpandableItem(
    initiallyExpanded: true,
    title: Text('Expandable item'),
    children: [
        ListTile(
            label: Text('Documents'),
            icon: SystemIcon(icon: XpSystemIcons.folderDocument)),
        ListTile(
            label: Text('Music'),
            icon: SystemIcon(icon: XpSystemIcons.folderMusic)),
        ListTile(
            label: Text('My PC'),
            icon: SystemIcon(icon: XpSystemIcons.computer))
        ]),
```

#### Button

![enabled button](images/button/button_enabled.png) ![disabled button](images/button/button_disabled.png)

```dart
 Button(
    child: const Text('Cancel'),
    onPressed: () {},
)
```

#### ProgressBar

you can provide a value between 0-100 to show progress, or null to show an indeterminated progress.

![xp style green progress bar](images/progressbar.png)

```dart
//with value
ProgressBar(value: 82.0)

//without value, indeterminated
ProgressBar()
```

#### Checkbox

![two xp style checkboxes](images/checkbox.png)

```dart
XpCheckbox(
    value: true,
    label: 'checkbox label',
    onChanged: (value) {}
)
XpCheckbox(
    value: false,
    label: 'checkbox label',
    onChanged: (value) {}
)
```

#### Textbox

The label can be a String or a Widget, is positioned by default on the top.

![two xp style text boxes](images/textbox.png)

```dart
Textbox(
    labelText: 'Label Top Text',
)
            
Textbox(
    labelWidget: SystemIcon(icon: XpSystemIcons.email),
    labelPosition: TextboxLabelPosition.left,
)
```
#### Dialogs
![two xp style alert dialog](images/alerts/alert.png)
```dart
 showXpDialog(
    context: context,
    builder: (context) => const XpAlertDialog(
                    title: 'Simple Alert',
                    content: const Text('This is a simple alert dialog'),
                    actions: [
                            Button(
                                child: const Text('Cancel'),
                                onPressed: () {},
                                ),
                            Button(
                                child: const Text('Accept'),
                                onPressed: () {},
                                )
                            ],
                  ));
```
```dart
AlertType.error;
```
![two xp style alert dialog](images/alerts/alert_error.png)
```dart
AlertType.warning;
```
![two xp style alert dialog](images/alerts/alert_warning.png)
```dart
AlertType.question;
```
![two xp style alert dialog](images/alerts/alert_question.png)
```dart
AlertType.info;
```
![two xp style alert dialog](images/alerts/alert_info.png)
```dart
AlertType.success;
```
![two xp style alert dialog](images/alerts/alert_success.png)


#### XpIcon
Show Xp-style icons from `SystemIcons` collection.
![two xp style computer](assets/system_icons/computer.png) ![two xp style folder](assets/system_icons/folderClose.png) ![two xp style volume icon](assets/system_icons/sound.png) ![two xp style folder](assets/system_icons/printer.png)

```dart
SystemIcon(icon: XpSystemIcons.folderDocument)
```

<hr>

### Contributing

You can contribute in different ways:

- Creating new WindowsXp styled components.
  - Please include screenshots in your PRs!
  - Please update the example and tests to include the new component!
- Improving existing components with better options.
- Improving documentation both in code and this README file.
- Fixing lint issues.
- Creating feature requests.
  - Please include a screenshot.
  - Also don't expect a quick response, this is a hobby project.
- Reporting bugs. 