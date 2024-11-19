import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_exam_project/screen/authService/authService.dart';

class SignUp extends StatelessWidget {
  final AuthService authController = Get.put(AuthService.authService);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Center(child: Text("Login",style: TextStyle(
          color: Colors.white
        ),)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.blue.shade900)))),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.blue.shade900))),
                      obscureText: true),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await authController.createWithEmailAndPassword(
                          emailController.text, passwordController.text);
                      Navigator.of(context).pushNamed('/home');
                    },
                    child: Text('Login'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/');
                      },
                      child: Text("you have "))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}