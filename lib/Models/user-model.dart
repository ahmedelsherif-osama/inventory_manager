import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  var userAccessLevel = 'guest';

  UserModel({
    required this.email,
    required this.userAccessLevel,
  });

  getAccessLevel() {
    return userAccessLevel;
  }

  toJson() {
    return {"email": email, "userAccessLevel": userAccessLevel};
  }

  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        email: data["email"], userAccessLevel: data["userAccessLevel"]);
  }
}
