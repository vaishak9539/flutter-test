import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/homepage.dart';
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

  Future<void> SignUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: paswordController.text.trim());

      String authId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("Users").doc(authId).set({
        "name": nameController.text,
        "phoneNumber": phoneNumberController.text,
        "email": emailController.text,
        "age": ageController.text,
        "password": paswordController.text,
        "userId": authId,
      });

      print("User Registered Successfully!");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Homepage(),
          ));
    } catch (e) {
      print('Unexpected error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            hintText: 'Name',
            controller: nameController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomTextField(
              hintText: 'PhoneNumber',
              controller: phoneNumberController,
            ),
          ),
          CustomTextField(
            hintText: 'email',
            controller: emailController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomTextField(
              hintText: 'Age',
              controller: ageController,
            ),
          ),
          CustomTextField(
            hintText: 'Password',
            controller: paswordController,
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () => SignUp(), child: CustomText(text: "Register"))
        ],
      ),
    );
  }
}


// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final nameController = TextEditingController();
//   final phoneNumberController = TextEditingController();
//   final emailController = TextEditingController();
//   final ageController = TextEditingController();
//   final paswordController = TextEditingController();

//   Future<void> SignUp() async {
//     if (nameController.text.isEmpty ||
//         phoneNumberController.text.isEmpty ||
//         emailController.text.isEmpty ||
//         ageController.text.isEmpty ||
//         paswordController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("All fields are required!")),
//       );
//       return;
//     }

//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: paswordController.text.trim(),
//       );

//       String authId = userCredential.user!.uid;

//       await FirebaseFirestore.instance.collection("Users").doc(authId).set({
//         "name": nameController.text,
//         "phoneNumber": phoneNumberController.text,
//         "email": emailController.text,
//         "age": ageController.text,
//         "userId": authId,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("User Registered Successfully!")),
//       );

//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => Homepage()),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     phoneNumberController.dispose();
//     emailController.dispose();
//     ageController.dispose();
//     paswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             CustomTextField(
//               hintText: 'Name',
//               controller: nameController,
//             ),
//             SizedBox(height: 10),
//             CustomTextField(
//               hintText: 'PhoneNumber',
//               controller: phoneNumberController,
//             ),
//             SizedBox(height: 10),
//             CustomTextField(
//               hintText: 'Email',
//               controller: emailController,
//             ),
//             SizedBox(height: 10),
//             CustomTextField(
//               hintText: 'Age',
//               controller: ageController,
//             ),
//             SizedBox(height: 10),
//             CustomTextField(
//               hintText: 'Password',
//               controller: paswordController,
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: SignUp,
//               child: CustomText(text: "Register"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
