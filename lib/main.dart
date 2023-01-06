
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kranite/pages/HomePage.dart';
import 'package:kranite/providers/CosmeticProvider.dart';
import 'package:kranite/providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CosmeticProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
    child: MaterialApp(
      theme: ThemeData(
        fontFamily: "Fortnite",
        colorScheme: ColorScheme.dark(),
        primaryColor: Colors.black38,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 25,
            // overflow: TextOverflow.visible
          ),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
