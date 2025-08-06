import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/task_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
    Get.find<AuthController>(); // Ensure AuthController exists
  }
}
