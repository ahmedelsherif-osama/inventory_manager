import 'package:firebase_database/firebase_database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_manager/Providers/keys-provider.dart';
import 'package:inventory_manager/Screens/LoginOrRegisterPage.dart';
import 'package:provider/provider.dart';

class OnHandStockPage extends StatefulWidget {
  OnHandStockPage({super.key});

  @override
  State<OnHandStockPage> createState() => _OnHandStockPageState();
}

class _OnHandStockPageState extends State<OnHandStockPage> {
  final List<String> StockList = <String>['A', 'B', 'C'];
  var db = FirebaseFirestore.instance;

  readDocs() {
    db.collection("documents").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          print("Successfully completed");
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    var keys = context.watch<KeysProvider>().keysGetter();
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.email);
      return (Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("whatever $keys"),
              ElevatedButton(onPressed: readDocs, child: Text("yalla"))
            ],
          ),
        ),
      ));
    } else {
      return LoginOrRegisterPage();
    }
  }
}
