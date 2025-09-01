import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manage_ment/contollers/data_controller.dart';
import 'package:task_manage_ment/models/user_model.dart';

class UserListWidget extends StatelessWidget {
  final DataController controller = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.userList.isEmpty) {
          return Center(child: Text("No users found"));
        }

        return ListView.builder(
          itemCount: controller.userList.length,
          itemBuilder: (context, index) {
            UserModel user = controller.userList[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.mobileNumber),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Edit functionality
                      _editScreen(
                        index,
                        controller.nameController.text,
                        controller.phoneController.text,
                      );
                      // Show edit dialog या navigate to edit screen
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      controller.delete(index);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  void _editScreen(int index, String name, String phone) {
    final controller = Get.find<DataController>();
    controller.nameController.text = name;
    controller.phoneController.text = phone;
    final formkey = GlobalKey<FormState>();
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        title: Text("Edit User"),
        content: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) => value!.isEmpty ? 'Enter Name' : null,
                controller: controller.nameController,
                decoration: InputDecoration(hintText: 'Enter Name'),
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                validator:
                    (value) => value!.isEmpty ? 'Enter Phone Number' : null,
                controller: controller.phoneController,
                decoration: InputDecoration(hintText: 'Enter Phone Number'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Save changes logic here
              if (!formkey.currentState!.validate()) return;
              controller.updateUser(index);
              Get.back();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
