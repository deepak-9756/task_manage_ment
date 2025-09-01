import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manage_ment/contollers/auth_controller.dart';
import 'package:task_manage_ment/views/login_page.dart';
import 'package:task_manage_ment/views/myhome_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [SizedBox(height: 50), Text("Signup Page"), _authForm()],
      ),
    );
  }

  Widget _authForm() {
    final controller = Get.find<AuthController>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (!value!.isEmpty && controller.isEmailValid(value)) {
                return null;
              }
              return 'Enter valid Email';
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: 'Enter Email'),
            controller: controller.emailController,
          ),

          GetBuilder<AuthController>(
            builder: (authController) {
              return TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.length < 4) {
                    return 'Enter Password';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                obscureText: authController.isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      authController.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      authController.togglePasswordVisibility();
                    },
                  ),
                ),
                controller: controller.passwordController,
              );
            },
          ),

          TextButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              if (await controller.signup()) Get.offAll(MyHomePage());
            },
            child: Text("Sign Up"),
          ),

          TextButton(
            onPressed: () {
              Get.offAll(LoginPage());
            },
            child: Text("Go to Login"),
          ),
        ],
      ),
    );
  }
}
