import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_manager/Resources/router.dart';
import 'package:inventory_manager/Screens/LoggedInPage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  void login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final user = credential.user;
      print(user?.uid);
      router.go('/loggedin');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      router.go('/loginerror');
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
            onSubmitted: (value) => login(),
            textAlign: TextAlign.center,
            controller: _emailController,
            decoration: InputDecoration(hintText: "Enter your email"),
          ),
          TextField(
            onSubmitted: (value) {
              login();
            },
            obscureText: true,
            textAlign: TextAlign.center,
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: "Enter your password",
            ),
          ),
          ElevatedButton(onPressed: login, child: Text("Login"))
        ],
      ));
    }
  }
}
