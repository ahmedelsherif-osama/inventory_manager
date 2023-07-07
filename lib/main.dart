import 'package:flutter/material.dart';
import 'package:inventory_manager/Resources/user-activity-detector.dart';

import 'Resources/router.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: 
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
