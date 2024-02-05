// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'loading_screen.dart';

void main() {
  runApp(Bitcoin());
}

class Bitcoin extends StatelessWidget {
  const Bitcoin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: LoadingScreen(),
    );
  }
}
