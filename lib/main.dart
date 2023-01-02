import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kranite/pages/HomePage.dart';
import 'package:kranite/providers/CosmeticProvider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ChangeNotifierProvider(
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
          ))),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
