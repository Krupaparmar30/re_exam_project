
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_exam_project/screen/authService/sign_in/sign_in.dart';
import 'package:re_exam_project/screen/authService/sign_up/sign_up.dart';
import 'package:re_exam_project/screen/homePage/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => SignIn(),
        ),
        GetPage(
          name: '/signUp',
          page: () => SignUp(),
        ),

        GetPage(
          name: '/home',
          page: () => homePage(),
        ),

      ],
    );
  }
}
