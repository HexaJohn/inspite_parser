import 'package:flutter/material.dart';
import 'package:september_flutter/src/core/app.dart';
import 'package:september_flutter/src/widgets/layout.dart';

void main() {
  App.addPlayer('client');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: TextScaffold(),
      ),
    );
  }
}
