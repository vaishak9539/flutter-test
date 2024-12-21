import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String name, String phoneNumber, String age, BuildContext context) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection("AddingUsers").doc(user.uid).set({
          'name': name,
          'phoneNumber': phoneNumber,
          'age': age,
          'userId': user.uid,
        });

        print("User added successfully!");
        Navigator.of(context).pop();
      } else {
        throw Exception("No user is currently signed in.");
      }
    } catch (e) {
      print('Error adding user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }
}
