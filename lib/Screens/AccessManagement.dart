import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:inventory_manager/Resources/router.dart";
import "package:inventory_manager/Screens/LoggedInPage.dart";
import 'package:inventory_manager/Screens/LoginOrRegisterPage.dart';

class AccessManagement extends StatelessWidget {
  AccessManagement({super.key});
  final FirebaseAuth _authService = FirebaseAuth.instance;
  var authEmail = FirebaseAuth.instance.currentUser?.email;
  var list;
  List<String> accessLevelsList = [
    'master user',
    'guest',
    'operations',
    'hub',
    'admin'
  ];

  List<Map<String, dynamic>> changeList = [];
  var dropdownValue;

  var databaseInstance = FirebaseFirestore.instance;

  updateDataOnDatabase() async {
    var email;
    var userAccessLevel;
    var userCollection = await databaseInstance.collection('users').get();
    for (var item in changeList) {
      email = item['email'];
      userAccessLevel = item['userAccessLevel'];
      var idToUpdateAccessFor = userCollection.docs
          .firstWhere((element) => element['email'] == email)
          .id;
      final docToUpdate =
          databaseInstance.collection('users').doc(idToUpdateAccessFor);
      docToUpdate.update({"userAccessLevel": userAccessLevel}).then(
          (value) => print("DocumentSnapshot successfully updated!"),
          onError: (e) => print("Error updating document $e"));
    }
  }

  verifyIfMaster() async {
    var collection = await databaseInstance.collection("users").get();
    list = collection.docs.map((doc) => doc.data()).toList();

    var item = list.firstWhere((element) => element['email'] == authEmail);
    var level = item['userAccessLevel'];
    if (level.toString() == 'master user') {
      return list;
    } else {
      _authService.signOut();
      router.pushReplacement('/login');
    }
  }

  addToChangeList(email, userAccessLevel) {
    changeList.add({"email": email, "userAccessLevel": userAccessLevel});
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<String>> convertedAccessLevelsList =
        <DropdownMenuEntry<String>>[];
    for (final String level in accessLevelsList) {
      convertedAccessLevelsList.add(
        DropdownMenuEntry<String>(value: level, label: level, enabled: true),
      );
    }

    if (FirebaseAuth.instance.currentUser != null) {
      verifyIfMaster();
      return FutureBuilder<dynamic>(
          future: verifyIfMaster(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(title: const Text('Users Access Levels List')),
                body: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.loose,
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 85,
                              margin: const EdgeInsets.all(2),
                              color: const Color.fromARGB(216, 252, 2, 98),
                              child: Center(
                                  child: Row(
                                children: [
                                  Text(
                                    '${list[index]['email']}',
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Text(
                                    '${list[index]['userAccessLevel']}',
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                  DropdownMenu<String>(
                                    initialSelection: list[index]
                                        ['userAccessLevel'],
                                    label: const Text('access level'),
                                    dropdownMenuEntries:
                                        convertedAccessLevelsList,
                                    onSelected: (String? level) {
                                      addToChangeList(
                                          list[index]['email'], level);
                                    },
                                  ),
                                ],
                              )),
                            );
                          }),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: ElevatedButton(
                        child: const Text("Update access"),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: const Text("Warning"),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Are you sure you wish to update these access(s)?"),
                                ),
                                actions: [
                                  ElevatedButton(
                                    child: const Text("Yes"),
                                    onPressed: () {
                                      updateDataOnDatabase();

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              loggedInPage(),
                                        ),
                                      );
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text("No"),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              AccessManagement(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Scaffold(
                body: Center(
                    child: Column(
                  children: [
                    Text("Loading"),
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
