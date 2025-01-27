import 'package:flutter/material.dart';
import 'package:scratch_clone/home_screen.dart';
import 'package:scratch_clone/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'scratch clone',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
}
}
