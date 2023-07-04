import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_manager/Screens/LoginPage.dart';

class OnHandStockPage extends StatelessWidget {
  final List<String> StockList = <String>['A', 'B', 'C'];
  OnHandStockPage({super.key});
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.email);
      return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: StockList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Center(child: Text('Entry ${StockList[index]}')),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    } else {
      return LoginPage();
    }
  }
}
