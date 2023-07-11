import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:inventory_manager/Resources/router.dart";
import 'package:inventory_manager/Screens/LoginOrRegisterPage.dart';

class loggedInPage extends StatelessWidget {
  loggedInPage({super.key});

  Future<dynamic> checkIfLoggedIn() async {
    final databaseInstance = FirebaseFirestore.instance;

    if (FirebaseAuth.instance.currentUser != null) {
      var authEmail = FirebaseAuth.instance.currentUser?.email;
      var docs = await databaseInstance.collection("users").get();
      var list = docs.docs.map((doc) => doc.data()).toList();
      var item = list.firstWhere((element) => element['email'] == authEmail);
      var level = item['userAccessLevel'];
      return level;
    } else {
      router.pushReplacement('/loginpage');
      return false;
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    router.go('/');
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return FutureBuilder<dynamic>(
          future: checkIfLoggedIn(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data) {
                case "guest":
                  return Scaffold(
                    body: Center(
                        child: Column(
                      children: [
                        const Text(
                            "Please contact admin to approve your access level"),
                        TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder()),
                          ),
                          onPressed: logout,
                          child: const Text("Ok"),
                        ),
                      ],
                    )),
                  );
                case "master user":
                  return (Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () => context.go('/managehubs'),
                            child: Text("Manage Hubs")),
                        ElevatedButton(
                            onPressed: () => context.go('/dispatchtablet'),
                            child: Text("Dispatch tablet")),
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
                        ElevatedButton(
                            onPressed: logout, child: Text("Logout")),
                      ],
                    ),
                  ));
                case "admin":
                  return (Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () => context.go('/managehubs'),
                            child: Text("Manage Hubs")),
                        ElevatedButton(
                            onPressed: () => context.go('/dispatchtablet'),
                            child: Text("Dispatch tablet")),
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
                            onPressed: logout, child: Text("Logout")),
                      ],
                    ),
                  ));

                case 'Operations':
                  return (Container(
                    child: Column(
                      children: [
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
                            onPressed: logout, child: Text("Logout")),
                        ElevatedButton(
                            onPressed: () => context.go('/dispatchtablet'),
                            child: Text("Dispatch tablet")),
                      ],
                    ),
                  ));
                case 'Hub user':
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
                            onPressed: () => context.go('/dispatchtablet'),
                            child: Text("Dispatch tablet")),
                        ElevatedButton(
                            onPressed: logout, child: Text("Logout")),
                      ],
                    ),
                  ));

                default:
                  return const Text("Contact admin plz");
              }
            } else {
              return const Scaffold(
                body: Center(
                    child: Column(
                  children: [
                    Text("You are getting redirected"),
                    CircularProgressIndicator(),
                  ],
                )),
              );
            }
          });
    } else {
      return LoginOrRegisterPage();
    }
  }
}
