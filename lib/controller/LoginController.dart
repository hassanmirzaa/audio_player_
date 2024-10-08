import 'package:audio_player_/views/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Show a message if email or password is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email and Password cannot be empty.")),
      );
      return;
    }

    isLoading = true; // Start loading
    notifyListeners();

    try {
      // Sign in with Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Successful login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful!")),
      );

      // Navigate to the HomeScreen after a successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle login errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.message}")),
      );
    } finally {
      isLoading = false; // Stop loading
      notifyListeners();
    }
  }
}
