import 'package:get/get.dart';
import 'package:task_manage_ment/binding/auth_binding.dart';
import 'package:task_manage_ment/routes/auth_middleware.dart';

import '../ui/pages/auth/login_page.dart';
import '../ui/pages/auth/signup_page.dart';
import '../ui/pages/splash/splash_page.dart';
import '../ui/pages/tasks/add_task_page.dart';
import '../ui/pages/tasks/edit_task_page.dart';
import '../ui/pages/tasks/task_list_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.SIGNUP,
      page: () => SignupPage(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.TASK_LIST,
      page: () => TaskListPage(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.ADD_TASK,
      page: () => AddTaskPage(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.EDIT_TASK,
      page: () => EditTaskPage(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
