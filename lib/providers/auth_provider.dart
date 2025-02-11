import 'package:dhruvil_interview_assignment/models/user_model.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;
  bool get isAuthenticated => _user != null;

  void login(String email, String password) {
    _user = User(email: email, name: 'DummyUserName');
    notifyListeners();
  }

  void signup(String email, String password) {
    _user = User(email: email, name: 'DummyUserName');
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
