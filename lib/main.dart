import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inventory_manager/Resources/user-activity-detector.dart';
import 'package:provider/provider.dart';

import 'Providers/keys-provider.dart';
import 'Resources/router.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: dotenv.env['apiKey'].toString(),
            authDomain: dotenv.env['authDomain'].toString(),
            projectId: dotenv.env['projectId'].toString(),
            storageBucket: dotenv.env['storageBucket'].toString(),
            messagingSenderId: dotenv.env['messagingSenderId'].toString(),
            appId: dotenv.env['appId'].toString(),
            measurementId: dotenv.env['measurementId'].toString()));
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    ChangeNotifierProvider<KeysProvider>(
      create: (_) => KeysProvider(),
      child: const MyApp(),
    ),
  );
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
