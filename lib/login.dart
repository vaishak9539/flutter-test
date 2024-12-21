import 'package:flutter/material.dart';
import 'package:fluttertest/widgets/custom_text.dart';
import 'package:fluttertest/widgets/custom_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(text: "Sign in"),
          CustomTextField(
            hintText: "Email",
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: "Email",
          ),
          SizedBox(
            height: 10,
          ),
           ElevatedButton(
              onPressed: () => null, child: CustomText(text: "Login"))
        ],
      ),
    );
  }
}