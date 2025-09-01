import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manage_ment/models/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DataController extends GetxController {
  RxList userList = <UserModel>[].obs; // Observable बनाएं
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'users'; // Collection name

  @override
  void onInit() {
    super.onInit();
    // App start पर data load करें
    fetchUsers();
  }

  // ✅ Firebase में User Add करना
  Future<void> addUser() async {
    try {
      // Local validation
      if (nameController.text.trim().isEmpty ||
          phoneController.text.trim().isEmpty) {
        Get.snackbar("Error", "Please fill all fields");
        return;
      }

      UserModel newUser = UserModel(
        name: nameController.text.trim(),
        mobileNumber: phoneController.text.trim(),
      );

      // Firebase में add करें
      DocumentReference docRef = await _firestore
          .collection(collectionName)
          .add(newUser.toJson());

      // Local list में भी add करें (with Firebase ID)
      userList.add(
        UserModel(
          id: docRef.id,
          name: newUser.name,
          mobileNumber: newUser.mobileNumber,
        ),
      );

      // Controllers clear करें
      nameController.clear();
      phoneController.clear();

      Get.snackbar("Success", "User added successfully!");
    } catch (e) {
      print("Error adding user: $e");
      Get.snackbar("Error", "Failed to add user");
    }
  }

  // ✅ Firebase से All Users Fetch करना
  Future<void> fetchUsers() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection(collectionName).get();

      userList.clear();
      for (var doc in snapshot.docs) {
        UserModel user = UserModel.fromJson(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
        userList.add(user);
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  // ✅ Firebase से User Delete करना
  Future<void> delete(int index) async {
    try {
      UserModel user = userList[index];

      if (user.id != null) {
        // Firebase से delete करें
        await _firestore.collection(collectionName).doc(user.id!).delete();
      }

      // Local list से भी remove करें
      userList.removeAt(index);

      Get.snackbar("Success", "User deleted successfully!");
    } catch (e) {
      print("Error deleting user: $e");
      Get.snackbar("Error", "Failed to delete user");
    }
  }

  // ✅ Firebase में User Update करना
  Future<void> updateUser(int index) async {
    try {
      UserModel oldUser = userList[index];

      if (oldUser.id != null) {
        UserModel updatedUser = UserModel(
          id: oldUser.id,
          name: nameController.text.trim(),
          mobileNumber: phoneController.text.trim(),
        );

        // Firebase में update करें
        await _firestore
            .collection(collectionName)
            .doc(oldUser.id!)
            .update(updatedUser.toJson());

        // Local list में भी update करें
        userList[index] = updatedUser;

        // Controllers clear करें
        nameController.clear();
        phoneController.clear();

        Get.snackbar("Success", "User updated successfully!");
      }
    } catch (e) {
      print("Error updating user: $e");
      Get.snackbar("Error", "Failed to update user");
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
