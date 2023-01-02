import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kranite/pages/HomePage.dart';
import 'package:kranite/pages/WishlistPage.dart';

import '../pages/LoginPage.dart';
import '../pages/RegisterPage.dart';

Drawer DrawerComponent(BuildContext context) {
  User? user = FirebaseAuth.instance.currentUser;
  return Drawer(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 35.0),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage())),
            title: Text("Today Shop"),
          ),
          user == null
              ? Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage())),
                      title: Text("Login"),
                    ),
                    ListTile(
                      leading: Icon(Icons.accessibility_new_rounded),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage())),
                      title: Text("Register"),
                    ),
                  ],
                )
              : Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.favorite),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WishListPage())),
                      title: Text("Wishlist"),
                    ),
                  ],
                ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Help"),
          ),
          user != null
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => FirebaseAuth.instance.signOut(),
                        child: ListTile(
                          leading: Icon(Icons.door_back_door_rounded),
                          title: Text("Logout"),
                        ),
                      ),
                    ],
                  ),
                )
              : Center()
        ],
      ),
    ),
  );
}
