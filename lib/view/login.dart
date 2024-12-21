import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/auth_service/auth_service.dart';
import 'package:fluttertest/view/homepage.dart';
import 'package:fluttertest/view/register.dart';
import 'package:fluttertest/widgets/custom_text.dart';
import 'package:fluttertest/widgets/custom_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "Sign in",
              size: 24,
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "Email",
              controller: emailController,
              validator: (value ) {
                if (value  == null || value .isEmpty) {
                  return "Please enter your email";
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value )) {
                  return 'Enter a valid email!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "Password",
              controller: passwordController,
              validator: (value ) {
                if (value  == null || value .isEmpty) {
                  return "please enter your password";
                }
                if (!RegExp((r'[A-Z]')).hasMatch(value )) {
                  return 'Uppercase letter is missing';
                }
                if (!RegExp((r'[a-z]')).hasMatch(value )) {
                  return 'Lowercase letter is missing';
                }
                if (!RegExp((r'[0-9]')).hasMatch(value )) {
                  return 'Digit is missing';
                }
                if (!RegExp((r'[!@#\$&*~]')).hasMatch(value )) {
                  return 'Special character is missing';
                }
                if (value .length < 5) {
                  return "Password must have 8 characters";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    authService.signIn(
                        emailController.text, passwordController.text, context);
                  }
                },
                child: CustomText(text: "Login")),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Center(child: Text("Don't have an account? sign up")))
          ],
        ),
      ),
    );
  }
}
