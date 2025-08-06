import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../services/firebase_service.dart';
import '../services/firestore_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseService>(FirebaseService(), permanent: true);
    Get.put<FirestoreService>(FirestoreService(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
