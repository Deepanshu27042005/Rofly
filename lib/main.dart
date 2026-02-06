import 'package:flutter/material.dart';
import 'package:roflly/view/mainScreen.dart';
import 'package:roflly/view/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showSplash = true;

  void showSplashScreen() {
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        showSplash = false;
      });
    });
  }


  @override
  void initState() {
    super.initState();
    showSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROFLly',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: showSplash ? splashScreen() :  MainScreen(), // currently always shows MainScreen
    );
  }
}
