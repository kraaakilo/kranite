import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  FirebaseAuth _instance = FirebaseAuth.instance;

  get getUser => _instance.currentUser;
  get instance => _instance;

  bool isLoggedIn() {
    return getUser != null ? true : false;
  }

  void signOut() {
    _instance.signOut();
  }
}
