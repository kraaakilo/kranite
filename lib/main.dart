import 'package:flutter/material.dart';
import 'package:kranite/pages/HomePage.dart';
import 'package:kranite/providers/CosmeticProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => CosmeticProvider(),
    child: MaterialApp(
      theme: ThemeData(
        fontFamily: "Fortnite",
        colorScheme: ColorScheme.dark(),
        primaryColor: Colors.black38,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 30,
            // overflow: TextOverflow.visible
          )
        )
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
