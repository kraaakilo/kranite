import 'package:flutter/material.dart';
import 'package:kranite/pages/HomePage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: "Fortnite",
      colorScheme: ColorScheme.dark(),
    ),
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}