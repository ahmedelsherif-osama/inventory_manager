import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_manager/Providers/keys-provider.dart';
import 'package:inventory_manager/Screens/LoginOrRegisterPage.dart';
import 'package:provider/provider.dart';

class OnHandStockPage extends StatelessWidget {
  OnHandStockPage({super.key});

  final List<String> hubsList = <String>['A', 'B', 'C'];

  var db = FirebaseFirestore.instance;

  readDocs() {
    db.collection("documents").get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<String>> convertedHubsList =
        <DropdownMenuEntry<String>>[];

    for (final String hub in hubsList) {
      convertedHubsList.add(
        DropdownMenuEntry<String>(value: hub, label: hub, enabled: true),
      );
    }
    var keys = context.watch<KeysProvider>().keysGetter();
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.email);
      return Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(2),
              child: Center(
                child: DropdownMenu<String>(
                  initialSelection: null,
                  label: const Text('Hubs List'),
                  dropdownMenuEntries: convertedHubsList,
                  onSelected: (String? hub) {

                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return LoginOrRegisterPage();
    }
  }
}
