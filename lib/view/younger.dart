import 'package:flutter/material.dart';
import 'package:fluttertest/service/firebase_service.dart';
import 'package:fluttertest/widgets/custom_text.dart';

class Younger extends StatefulWidget {
  const Younger({super.key});

  @override
  State<Younger> createState() => _YoungerState();
}

class _YoungerState extends State<Younger> {
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: firebaseService.getYoungerCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No users added",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var userDoc = snapshot.data!.docs[index];
              var username = userDoc["name"];
              var age = userDoc['age'].toString();
              return ListTile(
                leading: CircleAvatar(
                  child: Text(username[0].toUpperCase()),
                ),
                title: CustomText(text: username),
                subtitle: CustomText(text: "Age: $age"),
              );
            },
          );
        },
      ),
    );
  }
}
