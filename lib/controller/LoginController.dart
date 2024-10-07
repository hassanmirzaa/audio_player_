import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;
  
  bool isLoading = false;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void login(BuildContext context) {
    // Implement your login logic here
    // Set isLoading to true while performing login
    // Don't forget to set it to false once login is done
  }
}
