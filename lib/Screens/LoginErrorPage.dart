import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class LoginErrorPage extends StatelessWidget {
  const LoginErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        content: Text("Incorrect login details"),
        actions: [
          ElevatedButton(
              onPressed: () => context.go('/login'), child: Text("Ok"))
        ],
      ),
    );
  }
}
