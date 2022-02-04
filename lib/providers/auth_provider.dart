import 'package:flutter/material.dart';
import 'package:helpinghands/models/user_model.dart';
import 'package:helpinghands/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  final AuthService _authService = AuthService();

  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authService.getCurrentUser();
    _user = user;
    notifyListeners();
  }
}
