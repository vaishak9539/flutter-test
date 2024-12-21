import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(
      String name, String phoneNumber, String age, BuildContext context) async {
    try {
      await _firestore.collection("AddingUsers").add({
        'name': name,
        'phoneNumber': phoneNumber,
        'age': age,
      });

      print("User added successfully!");
      Navigator.of(context).pop();
    } catch (e) {
      print('Error adding user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  Stream<QuerySnapshot> getUserStream() {
    return _firestore.collection("AddingUsers").snapshots();
  }
}
