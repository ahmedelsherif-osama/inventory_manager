import 'package:flutter/material.dart';
import 'package:inventory_manager/Resources/user-activity-detector.dart';

import 'Resources/router.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAA60HEHiipxM5MRnyHXosJcjP9MORZqnc",
            authDomain: "inventory-manager-a3c5c.firebaseapp.com",
            projectId: "inventory-manager-a3c5c",
            storageBucket: "inventory-manager-a3c5c.appspot.com",
            messagingSenderId: "209701813131",
            appId: "1:209701813131:web:e47165b40db5899063cd8e",
            measurementId: "G-B99LBXXLRF"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserActivityDetector(
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
