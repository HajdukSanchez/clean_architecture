import 'package:flutter/material.dart';

import 'package:clean_architecture/injection_container.dart' as di;

void main() async {
  await di.init(); // Initialize the dependency injection container
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Architecture App',
    );
  }
}
