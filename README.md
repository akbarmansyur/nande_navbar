# nande_navbar
Plugin to create native navbar for iOS, Android, Web and Windows

## Usage
To use this plugin, add ```fancy_alert_dialog``` as a [dependency in your pubspec.yaml](https://flutter.io/platform-plugins/).

### Example
```dart
import 'package:flutter/material.dart';
import 'package:nande_navbar/nande_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nande Navbar',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Text('page = ${currentIndex + 1}'),
          ),
          NandeNavbar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            customItems: [
              NandeItem(
                  selectedIcon: Icons.home_outlined,
                  icon: Icons.home,
                  label: 'home'),
              NandeItem(
                  selectedIcon: Icons.explore_outlined,
                  icon: Icons.explore,
                  label: 'gallery'),
              NandeItem(
                  selectedIcon: Icons.play_arrow_outlined,
                  icon: Icons.play_arrow,
                  label: 'product'),
              NandeItem(
                  selectedIcon: Icons.shopping_cart_outlined,
                  icon: Icons.shopping_cart,
                  label: 'product'),
              NandeItem(
                  selectedIcon: Icons.person_outlined,
                  icon: Icons.person,
                  label: 'product'),
            ],
            backgroundColor: Colors.grey.shade200,
            height: 60,
            selectedIconSize: 28,
            unselectedIconSize: 24,
            enableLabel: true,
            labelStyle: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
```

## Description

A new Flutter package project

## Getting Started

To use this package and access its content, add this dependency to your pubspec.yaml

```
dependencies:
    nande_navbar: <latest_version>
```

And simply import the package using this code

```
import 'package:nande_navbar/nande_navbar.dart';
```

BTW `package:flutter/material.dart` is already imported when using this package so no need to re-import :)

