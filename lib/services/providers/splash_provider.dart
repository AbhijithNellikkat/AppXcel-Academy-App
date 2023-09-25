import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SplashProvider() {
    firebaseAuth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }
}
