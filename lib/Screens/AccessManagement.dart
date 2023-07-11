import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:inventory_manager/Screens/LoginOrRegisterPage.dart';

class AccessManagement extends StatelessWidget {
  AccessManagement({super.key});

  var databaseInstance = FirebaseFirestore.instance;
  doSomething() async {
    var authEmail = FirebaseAuth.instance.currentUser?.email;
    var docs = await databaseInstance.collection("users").get();
    var list = docs.docs.map((doc) => doc.data()).toList();
    print(list.runtimeType);

    /*var item = list.firstWhere((element) => element['email'] == authEmail);
    var level = item['userAccessLevel'];
    return level;*/
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.email);
      doSomething();
      return Container(
        child: Text("Access Mgmt"),
      );
    } else {
      return LoginOrRegisterPage();
    }
  }
}
