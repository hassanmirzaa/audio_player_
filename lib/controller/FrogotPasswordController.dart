import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
 // final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String errorMessage = '';

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    final String email = emailController.text.trim();

    if (email.isEmpty) {
      errorMessage = "Please enter your email";
      notifyListeners();
      return;
    }

    try {
      isLoading = true;
      notifyListeners();
     // await _auth.sendPasswordResetEmail(email: email);
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password reset email sent")),
      );
      Navigator.pop(context); // Go back to the previous screen
    } catch (error) {
      errorMessage = error.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
