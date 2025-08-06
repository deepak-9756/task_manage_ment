import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/task_model.dart';
import '../services/firebase_service.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseService _firebaseService = Get.find<FirebaseService>();

  CollectionReference get _tasksCollection {
    return _firestore
        .collection('users')
        .doc(_firebaseService.currentUserId)
        .collection('tasks');
  }

  Stream<List<TaskModel>> getTasks() {
    return _tasksCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TaskModel.fromJson(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          }).toList();
        });
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await _tasksCollection.add(task.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _tasksCollection.doc(task.id).update(task.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<TaskModel?> getTask(String taskId) async {
    try {
      final doc = await _tasksCollection.doc(taskId).get();
      if (doc.exists) {
        return TaskModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      throw e;
    }
  }
}
