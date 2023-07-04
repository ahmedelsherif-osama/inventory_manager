import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_manager/Screens/LoggedInPage.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String dropdownvalue = "value";
  final controller = TextEditingController();

  final email = "ahmedelsherif@gmail.com";

  final password = "Talabat@123";

  var items = [
    'Admin',
    'Operations',
    'Hub',
  ];

  var db = FirebaseFirestore.instance;

  void sendData() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: controller.text,
        password: password,
      );

      print(credential);

      // Create a new user with a first and last name
      final user = <String, dynamic>{
        email: controller.text,
        password: password,
      };
      // Add a new document with a generated ID
      db.collection("users").add(user).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.email);
      return loggedInPage();
    } else {
      return Scaffold(
          body: Column(
        children: [
          TextField(
            textAlign: TextAlign.center,
            controller: controller,
            decoration: InputDecoration(hintText: "email"),
          ),
          Text("last name"),
          TextFormField(),
          Text("email"),
          TextFormField(),
          Text("password"),
          TextFormField(),
          DropdownButton(
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (nothing) {
              print("object");
            },
          ),
          ElevatedButton(onPressed: sendData, child: Text("Create Account"))
        ],
      ));
    }
  }
}
