# J1 Icons

This UI library comes with some built-in icons.

## Installation

In order to use these icons, the icon font must be added to the consuming app. In order to do so, please add the respective font file to the consuming projects's `pubspec.yaml` with the following snippet:

```
flutter:
  fonts:
    - family: {{Icon Font Name}}
      fonts:
        - asset: packages/j1_ui/fonts/{{Icon Font Name}}.ttf
```

For more details please see the Flutter documentation on [exporting fonts from a package](https://docs.flutter.dev/cookbook/design/package-fonts).