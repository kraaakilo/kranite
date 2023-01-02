import 'package:flutter/material.dart';

AppBar TransparentAppBar(BuildContext context) {
  return AppBar(
    leading: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Icon(Icons.arrow_back),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
