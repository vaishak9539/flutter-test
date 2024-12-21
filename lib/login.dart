import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/homepage.dart';
import 'package:fluttertest/register.dart';
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

  Future<void> Signin() async {
    if (formkey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      UserCredential userDara = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Homepage(),
          ));
    }
  }

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
              validator: (value1) {
                if (value1 == null || value1.isEmpty) {
                  return "Please enter your email";
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value1)) {
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
              validator: (value2) {
                if (value2 == null || value2.isEmpty) {
                  return "please enter your password";
                }
                if (!RegExp((r'[A-Z]')).hasMatch(value2)) {
                  return 'Uppercase letter is missing';
                }
                if (!RegExp((r'[a-z]')).hasMatch(value2)) {
                  return 'Lowercase letter is missing';
                }
                if (!RegExp((r'[0-9]')).hasMatch(value2)) {
                  return 'Digit is missing';
                }
                if (value2.length < 5) {
                  return "Password must have 8 characters";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () => Signin(), child: CustomText(text: "Login")),
                SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
            },
            child: Center(child: Text("Don't have an account? sign up")))
          ],
        ),
      ),
    );
  }
}
