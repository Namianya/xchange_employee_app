import 'package:flutter/material.dart';
import 'package:ui/theme.dart';
import 'package:xchange/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: 'Flutter Demo',
      theme: myTheme,
      home: const Home(),
    );
  }
}
