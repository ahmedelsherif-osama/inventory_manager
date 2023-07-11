import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:inventory_manager/Screens/LoggedInPage.dart';

class LoginOrRegisterPage extends StatelessWidget {
  LoginOrRegisterPage({super.key});

  final databaseInstance = FirebaseFirestore.instance;
  final envv = dotenv.env;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            showAuthActionSwitch: false,
            providerConfigs: [
              GoogleProviderConfiguration(
                  clientId: envv['clientId'].toString()),
            ],
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text(
                        'Welcome to FlutterFire, please sign in with Google!')
                    : const Text(
                        'Welcome to FlutterFire, please sign in with Google!'),
              );
            },
          );
        } else {
          return loggedInPage();
        }
      },
    );
  }
}
