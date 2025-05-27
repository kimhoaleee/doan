import 'package:flutter/material.dart';
import '../models/User.dart';

enum AuthState { loggedOut, loggedIn }

class AuthController extends ChangeNotifier {
  AuthState _authState = AuthState.loggedOut;
  User? _currentUser;

  AuthState get authState => _authState;
  User? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    // In a real app, you would authenticate with a backend here
    // For now, we'll just simulate a successful login
    try {
      // Simulate network delay
      await Future.delayed(Duration(seconds: 1));
      
      _currentUser = User(
        id: "1",
        name: "Lê Thị Kim Hoa",
        email: email,
        profileImage: "assets/images/profile.png",
      );
      
      _authState = AuthState.loggedIn;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    // In a real app, you would register with a backend here
    // For now, we'll just simulate a successful registration
    try {
      // Simulate network delay
      await Future.delayed(Duration(seconds: 1));
      
      _currentUser = User(
        id: "1",
        name: name,
        email: email,
        profileImage: "assets/images/profile.png",
      );
      
      _authState = AuthState.loggedIn;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() {
    _authState = AuthState.loggedOut;
    _currentUser = null;
    notifyListeners();
  }
}
