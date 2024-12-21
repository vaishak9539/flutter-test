import 'package:flutter/material.dart';
import 'package:fluttertest/service/firebase_service.dart';
import 'package:fluttertest/view/tabbars.dart';
import 'package:fluttertest/widgets/custom_text.dart';

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
  final FirebaseService firebaseService = FirebaseService();
  final searchController = TextEditingController();

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          width: 280,
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search by name or phone",
              prefixIcon: Icon(Icons.search),
              // border: InputBorder.none
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:10 ),
            child: IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Tabbars(),));
            }, icon: Icon(Icons.sort),),
          )
        ],
      ),
      body: StreamBuilder(
          stream: firebaseService.getUserStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("No user Addad",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 18,
                    )),
              );
            }

            final users = snapshot.data!.docs.where((doc) {
              final name = doc['name'].toLowerCase();
              final phoneNumber = doc['phoneNumber'].toLowerCase();
              return name.contains(searchQuery) ||
                  phoneNumber.contains(searchQuery);
            }).toList();

            if (users.isEmpty) {
              return Center(
                child: Text("No matching users found"),
              );
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var userid = users[index];
                var userName = userid["name"];
                var userphone = userid["phoneNumber"];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(userName[0].toUpperCase()),
                  ),
                  title: CustomText(text: userName),
                  subtitle: CustomText(text: userphone),
                );
              },
            );
          }),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your PhoneNumber";
                                    }
                                    if (value.length < 10) {
                                      return "Contact number must be at least 10 digits";
                                    }
                                    return null;
                                  },
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your age';
                                    }
                                    return null;
                                  },
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
                          if (formkey.currentState!.validate()) {
                            firebaseService.addUser(
                                nameController.text,
                                phoneNumberController.text,
                                ageController.text,
                                context);
                          }
                          nameController.clear();
                          phoneNumberController.clear();
                          ageController.clear();
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
