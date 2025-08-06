import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    // If user is authenticated and trying to access auth pages
    if (authController.isAuthenticated.value &&
        (route == AppRoutes.LOGIN || route == AppRoutes.SIGNUP)) {
      return const RouteSettings(name: AppRoutes.TASK_LIST);
    }

    // If user is not authenticated and trying to access protected pages
    if (!authController.isAuthenticated.value &&
        route != AppRoutes.LOGIN &&
        route != AppRoutes.SIGNUP &&
        route != AppRoutes.SPLASH) {
      return const RouteSettings(name: AppRoutes.LOGIN);
    }

    return null;
  }
}
