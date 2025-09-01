import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;
  bool isPasswordVisible = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  bool isEmailValid(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<bool> signup() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    return auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((UserCredential userCredential) {
          // Signup successful
          print("Signup successful: ${userCredential.user?.email}");
          return true;
        })
        .catchError((error) {
          // Handle signup error
          print("Signup error: $error");
          return false;
        });
  }

  Future<bool> login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    return auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((UserCredential userCredential) {
          // Login successful
          print("Login successful: ${userCredential.user?.email}");
          return true;
        })
        .catchError((error) {
          // Handle login error
          print("Login error: $error");
          return false;
        });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
