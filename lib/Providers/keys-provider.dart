import "package:flutter/material.dart";

class KeysProvider with ChangeNotifier {
  List _keys = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8.9,
    10,
    11,
    12,
    13,
    14,
    15,
    17,
    17,
    18,
    19,
    20
  ]; //is it fine to have a state/private attribute/variable not be final
  List get keys => _keys;

  keysGetter() {
    return _keys;
  }

  keysSetter(keys2) {
    _keys = keys2;
    notifyListeners();
  }
}
