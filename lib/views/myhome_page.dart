import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manage_ment/contollers/auth_controller.dart';
import 'package:task_manage_ment/contollers/data_controller.dart';
import 'package:task_manage_ment/widgets/user_list_widget.dart';

class MyHomePage extends StatelessWidget {
  final controller = Get.find<DataController>();
  final authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>(); // Typo fix: foreKey -> formKey

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          TextButton(
            onPressed: () async {
              await authController.logout();
            },
            child: Text("Logout"),
          ),
          _formField(),
          UserListWidget(),
        ],
      ),
    );
  }

  Widget _formField() {
    return Form(
      key: formKey, // Key assign करें
      child: Column(
        children: [
          TextFormField(
            validator: (value) => value!.isEmpty ? 'Enter Name' : null,
            controller: controller.nameController,
            decoration: InputDecoration(hintText: 'Enter Name'),
          ),
          TextFormField(
            validator: (value) => value!.isEmpty ? 'Enter Phone Number' : null,
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(hintText: 'Enter Phone Number'),
          ),

          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              await controller.addUser(); // Async call करें
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
