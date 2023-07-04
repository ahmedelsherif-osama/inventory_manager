import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class FileTypeErrorPage extends StatelessWidget {
  const FileTypeErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        content: Text("Please use CSV files only"),
        actions: [
          ElevatedButton(
              onPressed: () => context.go('/newshipment'), child: Text("Ok"))
        ],
      ),
    );
  }
}
