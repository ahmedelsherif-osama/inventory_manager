//ideally what do we want from this class?
// we want a class where we can pass the uploded file bytes from file picker
// then get from that file a list that we can use to save documents to DB
// so far we succeeded with converting the file to a list
//now we need to use this list to add documents to db
// this is all done, within the current scope/story

import 'dart:convert';
import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_manager/Screens/LoggedInPage.dart';

class CSVToFirebase {
  var db = FirebaseFirestore.instance;

  int columns = 20;

  String text = "";
  List textList = [];
  List keys = [];
  List values = [];
  CSVToFirebase(int columns, String text) {
    this.columns = columns;
    this.text = text;

    var counter = 1;

    /*the below part is for replacing any intended commas with dash so
    once we are splitting the text into a list there will be no confusion
    to do that we will have to find first ," and first ",
    then wihtin that subtsring replace all commas with dashes
    finding them is easy, replacing is a bit more difficult, let do it step by step*/

    //first step, lets find the start and end
    int start;
    int end;
    while (text.contains(',"') || text.contains('",')) {
      start = text.indexOf(',"');
      end = text.indexOf('",');
      //done, now lets replace all the commas within this range with dashes
      //how will we do that?
      //lets get only the text between the quotes
      var buffer = text.substring(start + 2, end - 1);
      //great, now lets replace all the commas within the text with dashes
      var buffer2 = buffer.replaceAll(",", "-");
      //ok, now lets replace this part of text, the quoted part, wiht our
      //new text without commas in between

      text = text.substring(0, start) + "," + buffer2 + text.substring(end + 1);
    }
    //done with replacing commas with dashes

    var textList = text.split(",");
    var newColumns = columns;

    //now lets replace lines breaks with commas within the list itself
    //we will re=split it later
    for (int i = columns - 1; i < textList.length - 1; i += 19) {
      textList[i] = textList[i].replaceFirst('\n', ',');
    }
    //done with replacing line breaks with commas

    //now lets convert it back to text, so we can split by commas again
    text = "";
    for (int i = 0; i < textList.length; i++) {
      if (i == 0) {
        text = text + textList[i];
      } else {
        text = "$text,${textList[i]}";
      }
    }
    //done with converting back to text

    //lets split it to list again
    textList = text.split(",");
    //done with splitting it to list

    //now lets createa a list of keys
    keys = textList.getRange(0, columns).toList();
    //done with list of keys

    //actually, lets just get a list of the values alone without the keys
    var values = textList.getRange(columns, textList.length).toList();

    //print(values);

    //lets loop through it and create documents with keys and values
    Map<String, String> document = new Map<String, String>();
    var y = 0;
    for (int i = 0; i < (values.length); i++) {
      document[keys[y]] = values[i];
      if (y == ((keys.length) - 1)) {
        db.collection("documents").add(document).then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
        y = 0;
        print('document number ${(i + 1) / columns}');
        document = new Map<String, String>();
      } else {
        y++;
      }
    }
  }
}
