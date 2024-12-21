// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/view/homepage.dart';
import 'package:fluttertest/view/login.dart';
import 'package:fluttertest/widgets/custom_text.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(String email, String password, String name,
      String phoneNumber, String age, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      String authId = userCredential.user!.uid;

      await _firestore.collection("Users").doc(authId).set({
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "age": age,
        "password": password,
        "userId": authId,
      });

      print("User Registered Successfully!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    } catch (e) {
      print('Unexpected error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText(text: "Error: ${e.toString()}", size: 18)),
      );
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ),
      );
    } catch (e) {
      print('Unexpected error during sign-in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText(text: "Error: ${e.toString()}", size: 18)),
      );
    }
  }
}
