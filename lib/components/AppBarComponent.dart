import 'package:flutter/material.dart';

AppBar AppBarComponent() {
  return AppBar(
    toolbarHeight: 85,
    elevation: 0,
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Image.asset(
        "images/fortnite.png",
        width: 200,
      ),
    ),
    leading: IconButton(
      icon: const Icon(Icons.menu),
      onPressed: null,
    ),
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          children: const [
            Icon(Icons.favorite),
          ],
        ),
      )
    ],
  );
}
