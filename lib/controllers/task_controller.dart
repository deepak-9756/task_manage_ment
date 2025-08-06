import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/task_model.dart';
import '../routes/app_routes.dart';
import '../services/firestore_service.dart';

class TaskController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedFilter = 'All'.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final RxString selectedStatus = 'Pending'.obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    _firestoreService.getTasks().listen((taskList) {
      tasks.value = taskList;
    });
  }

  List<TaskModel> get filteredTasks {
    if (selectedFilter.value == 'All') {
      return tasks;
    }
    return tasks.where((task) => task.status == selectedFilter.value).toList();
  }

  Future<void> addTask() async {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Title is required',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final task = TaskModel(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        status: selectedStatus.value,
        createdAt: DateTime.now(),
      );

      await _firestoreService.addTask(task);

      _clearForm();
      Get.back();

      Get.snackbar(
        'Success',
        'Task added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add task',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTask(TaskModel task) async {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Title is required',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final updatedTask = task.copyWith(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        status: selectedStatus.value,
      );

      await _firestoreService.updateTask(updatedTask);

      _clearForm();
      Get.back();

      Get.snackbar(
        'Success',
        'Task updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update task',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _firestoreService.deleteTask(taskId);
      Get.snackbar(
        'Success',
        'Task deleted successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete task',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void navigateToAddTask() {
    _clearForm();
    Get.toNamed(AppRoutes.ADD_TASK);
  }

  void navigateToEditTask(TaskModel task) {
    titleController.text = task.title;
    descriptionController.text = task.description;
    selectedStatus.value = task.status;
    Get.toNamed(AppRoutes.EDIT_TASK, arguments: task);
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  void _clearForm() {
    titleController.clear();
    descriptionController.clear();
    selectedStatus.value = 'Pending';
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
