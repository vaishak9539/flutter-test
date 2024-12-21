import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ageController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("data")),

      // floatingActionButton: FloatingActionButton(
      //   shape:RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20)
      //   ),
      //   onPressed: () => null,child: Icon(Icons.add),),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text("Add User"),
                  content: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          SizedBox(
                              height: 50,
                              width: 230,
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: "Name",
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                                height: 50,
                                width: 230,
                                child: TextFormField(
                                  controller: phoneNumberController,
                                  decoration: InputDecoration(
                                    hintText: "ph Number",
                                  ),
                                  keyboardType: TextInputType.number,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                                height: 50,
                                width: 230,
                                child: TextFormField(
                                  controller: ageController,
                                  decoration: InputDecoration(
                                    hintText: "age",
                                  ),
                                  keyboardType: TextInputType.number,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              phoneNumberController.text.isNotEmpty &&
                              ageController.text.isNotEmpty
                              ) {
                            FirebaseFirestore.instance
                                .collection("AddingUsers")
                                .add({
                              'name': nameController.text,
                              'phoneNumber': phoneNumberController.text,
                              'age' : ageController.text
                            });
                            nameController.clear();
                            phoneNumberController.clear();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("Save"))
                  ],
                );
              });
        },
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
