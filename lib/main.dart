import 'package:flutter/material.dart';

import 'package:clean_architecture/injection_container.dart' as di;
import 'package:clean_architecture/core/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // It is important to add this, to ensure not to have problems with Futures initialized the injection container
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
      routes: routes,
      initialRoute: PageName.numberTrivia.name,
    );
  }
}
