# xp_ui

Windows Xp UI components for Flutter apps

## Screenshots
<hr>
![screenshot of fñutter app window usin xp_ui components](/images/screenshot.png)

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Components
<hr>

### XpApp
Required to load all Xp styles, is compatible with standart flutter material Widgets.
```dart
 XpApp(
    title: 'Flutter Demo',
    theme: XpThemeData(),
    debugShowCheckedModeBanner: false,
    home: const MyHomePage(title: 'Flutter Demo Home Page'),
);
```

### Button
![enabled button](images/button/button_enabled.png) ![disabled button](images/button/button_disabled.png)
```dart
 Button(
    child: const Text('Cancel'),
    onPressed: () {},
)
```

### ProgressBar
you can provide a value between 0-100 to show progress, or null to show an indeterminated progress.

![xp style green progress bar](images/progressbar.png)

```dart
ProgressBar(
    value: 82.0
)
```
### Checkbox
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
