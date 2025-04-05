# Material Dev Tools

**Material Dev Tools** is a Flutter package designed to enhance your development workflow by 
offering **real-time previews** of Material Design components. This tool helps developers inspect,
tweak, and test UI elements efficiently, making it easier to build beautiful and consistent 
Material Design applications.

## ✨ Features

- 🔍 Live Previews – Instantly see changes to Material components.
- 🎨 Theme Customization – Adjust themes dynamically.
- 🛠 Component Inspector – Debug UI elements with ease.
- ⚡ Hot Reload Support – Seamlessly integrate into your Flutter workflow.

## 🚀 Installation

Add `material_dev_tools` to your `pubspec.yaml`:

```yaml
dev_dependencies:
  material_dev_tools: latest_version
```

Then run:
```shell
flutter pub get
```

## 📌 Usage
Ensure your app is wrapped with `MaterialApp`, setting `theme` and `darkTheme`, and using `Scaffold`
in your UI:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('Material Dev Tools')),
        body: Center(child: Text('Hello, world!')),
      ),
    ),
  );
}
```

## 📖 Documentation

Open **Dart DevTools**, and you'll see **live previews** of Material components with your theming
applied. No extra setup required!

## 🎯 Contributing

Contributions are welcome! Feel free to open issues and pull requests.

## 📜 License

This project is licensed under the MIT License.
