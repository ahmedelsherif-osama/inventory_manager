import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:inventory_manager/Providers/keys-provider.dart';
import 'package:inventory_manager/Resources/csv-to-firebase.dart';

import 'package:inventory_manager/Resources/router.dart';
import 'package:inventory_manager/Screens/LoginOrRegisterPage.dart';
import 'package:provider/provider.dart';

class NewShipmentImportPage extends StatefulWidget {
  NewShipmentImportPage({super.key});

  @override
  State<NewShipmentImportPage> createState() => _NewShipmentImportPageState();
}

class _NewShipmentImportPageState extends State<NewShipmentImportPage> {
  var _decodedBytes;

// Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref();

  void uploadFile(file) async {
    final storageRef = FirebaseStorage.instance.ref(file.name);
    final bytes = file.bytes;

    const utf8Decoder = Utf8Decoder(allowMalformed: true);
    _decodedBytes = utf8Decoder.convert(bytes);
    var csv = CSVToFirebase(20, _decodedBytes);
    var otherKeys = csv.keys;

    context.read<KeysProvider>().keysSetter(otherKeys);
    print("other keys $otherKeys");
    print("provider keys ${context.read<KeysProvider>().keysGetter()}");

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
    var keys = context.watch<KeysProvider>().keysGetter();
    if (FirebaseAuth.instance.currentUser != null) {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("Import New Shipment"),
              ElevatedButton(
                onPressed: () {
                  _pickFile();

                  //QQ why the below isnt reponsive
                  //QQ whats the point of using const and final extensively in flutter
                  context.read<KeysProvider>().keysSetter(keys);
                },
                //onPressed: () => context.go('/onhand'),

                child: Text("Import new shipment "),
              ),
            ],
          ),
        ),
      );
    } else {
      return LoginOrRegisterPage();
    }
  }
}
