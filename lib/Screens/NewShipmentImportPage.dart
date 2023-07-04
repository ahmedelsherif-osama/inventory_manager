import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:inventory_manager/Resources/csv-to-firebase.dart';

import 'package:inventory_manager/Resources/router.dart';
import 'package:inventory_manager/Screens/LoginPage.dart';

class NewShipmentImportPage extends StatelessWidget {
  NewShipmentImportPage({super.key});

  var _decodedBytes;
// Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref();

  void uploadFile(file) async {
    final storageRef = FirebaseStorage.instance.ref(file.name);
    final bytes = file.bytes;

    const utf8Decoder = Utf8Decoder(allowMalformed: true);
    _decodedBytes = utf8Decoder.convert(bytes);
    CSVToFirebase(20, _decodedBytes);

    try {
      await storageRef.putData(bytes!);
    } catch (e) {
      print(e);
      // ...
    }
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result == null) {
      return;
    }

    PlatformFile file = result.files.single;

    if (file.extension != 'csv') {
      router.go('/errorpage');
    } else {
      uploadFile(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return Scaffold(
        body: Column(
          children: [
            Text("Import New Shipment"),
            ElevatedButton(
                onPressed: () {
                  _pickFile();
                },
                //onPressed: () => context.go('/onhand'),
                child: Text("Import new shipment"))
          ],
        ),
      );
    } else {
      return LoginPage();
    }
  }
}
