import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:inventory_manager/Resources/router.dart";
import "package:inventory_manager/Screens/LoginPage.dart";

class loggedInPage extends StatelessWidget {
  const loggedInPage({super.key});
  void logout() async {
    await FirebaseAuth.instance.signOut();
    router.go('/');
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.email);
      return (Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => context.go('/managehubs'),
                child: Text("Manage Hubs")),
            ElevatedButton(
                onPressed: () => context.go('/onhand'),
                child: Text("On Hand Stock")),
            ElevatedButton(
                onPressed: () => context.go('/newshipment'),
                child: Text("Stock Import")),
            ElevatedButton(
                onPressed: () => context.go('/deployboxes'),
                child: Text("Deploy and Assign Boxes to Hubs")),
            ElevatedButton(
                onPressed: () => context.go('/accessmgmt'),
                child: Text("Access Management")),
            ElevatedButton(onPressed: logout, child: Text("Logout")),
          ],
        ),
      ));
    } else {
      print("not logged in");
      return LoginPage();
    }
  }
}
