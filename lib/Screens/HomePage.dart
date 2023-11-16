import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:inventory_manager/Screens/LoggedInPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void test(){
    
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.email);
      return loggedInPage();
    } else {
      return Container(
        child: Column(
          children: [
            Text("Welcome to Inventory Manager"),
            ElevatedButton(
                onPressed: () => context.go('/login'),
                child: Text("Log in - Register")),
            ElevatedButton(
                onPressed: () => context.go('/aboutus'),
                child: Text("Tutorial - About us")),
          ],
        ),
      );
    }
  }
}
