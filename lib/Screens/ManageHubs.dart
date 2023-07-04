import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:inventory_manager/Screens/LoginPage.dart";

class ManageHubs extends StatelessWidget {
  const ManageHubs({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.email);
      return Container(
        child: Text("Manage Hubs"),
      );
    } else {
      return LoginPage();
    }
  }
}
