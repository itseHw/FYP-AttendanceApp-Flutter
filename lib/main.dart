import 'package:attendance_fyp_app/home/login_page.dart';
import 'package:attendance_fyp_app/signUp_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/auth_controller.dart';

void main() async{
  //for try to resolve missing words
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 500));
  //end for trying
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // debugShowMaterialGrid: false,
      title: 'Company App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      // home: SignUpPage(),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

