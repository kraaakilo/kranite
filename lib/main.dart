import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kranite/pages/wrappers/AuthWrapper.dart';
import 'package:kranite/providers/CosmeticProvider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => CosmeticProvider(),
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
            fontSize: 30,
            // overflow: TextOverflow.visible
          ),
        ),
      ),
      home: AuthWrapper(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
