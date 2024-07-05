import 'package:flutter/material.dart';
import 'package:memory_bartender/pages/splash_screen.dart';
import 'package:memory_bartender/styles/colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Epilogue',
        primaryColor: MemoColors.brownie,
        splashColor: MemoColors.beige
      ),
      home: SplashScreen(),
    );
  }
}
