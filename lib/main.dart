import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_manage_ment/contollers/auth_controller.dart';
import 'package:task_manage_ment/contollers/data_controller.dart';
import 'package:task_manage_ment/views/login_page.dart';
import 'package:task_manage_ment/views/myhome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(DataController());
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print(
            'StreamBuilder rebuilt - Connection: ${snapshot.connectionState}',
          );
          print('Has data: ${snapshot.hasData}, Data: ${snapshot.data}');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.hasData && snapshot.data != null) {
            print('Showing HomePage');
            return MyHomePage();
          } else {
            print('Showing LoginPage');
            return LoginPage();
          }
        },
      ),
    );
  }
}
