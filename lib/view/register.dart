import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/service/auth_service.dart';
import 'package:fluttertest/view/homepage.dart';
import 'package:fluttertest/widgets/custom_text.dart';
import 'package:fluttertest/widgets/custom_textfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final paswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    ageController.dispose();
    paswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hintText: 'Name',
              controller: nameController,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                hintText: 'PhoneNumber',
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your PhoneNumber";
                  }
                  if (value.length < 10) {
                    return "Contact number must be at least 10 digits";
                  }
                  return null;
                },
              ),
            ),
            CustomTextField(
              hintText: 'email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'Enter a valid email!';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                hintText: 'Age',
                controller: ageController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
            ),
            CustomTextField(
              hintText: 'Password',
              controller: paswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter your password";
                }
                if (!RegExp((r'[A-Z]')).hasMatch(value)) {
                  return 'Uppercase letter is missing';
                }
                if (!RegExp((r'[a-z]')).hasMatch(value)) {
                  return 'Lowercase letter is missing';
                }
                if (!RegExp((r'[0-9]')).hasMatch(value)) {
                  return 'Digit is missing';
                }
                if (value.length < 5) {
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
                  if (formKey.currentState!.validate()) {
                    _authService.signUp(
                        emailController.text,
                        paswordController.text,
                        nameController.text,
                        phoneNumberController.text,
                        ageController.text,
                        context);
                  }
                },
                child: CustomText(text: "Register"))
          ],
        ),
      ),
    );
  }
}
