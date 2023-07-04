import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_manager/Screens/LoginPage.dart';

class DeployBoxesToHub extends StatelessWidget {
  final hubs = ['marina', 'business bay', 'warqa'];
  DeployBoxesToHub({super.key});
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.email);
      return (Scaffold(
        body: Column(
          children: [
            Text("enter SN's separated by a space"),
            TextFormField(),
            Text("Or scan QR code below"),
            SizedBox.square(dimension: 50),
            DropdownButton(
              items: hubs.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (nothing) {
                print("object");
              },
            ),
            ElevatedButton(
                onPressed: () => context.go('/onhand'),
                child: Text("Deploy to Hub"))
          ],
        ),
      ));
    } else {
      return LoginPage();
    }
  }
}
