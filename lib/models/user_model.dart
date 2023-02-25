import 'package:firebase_database/firebase_database.dart';

class User {
  final String userName;
  final String email;
  final String name;
  final String phoneNumber;

  const User(
      this.userName,
      this.email,
      this.name,
      this.phoneNumber
      );

  factory User.fromDataSnapshot(DataSnapshot document) {
    return User(
        document.child('userName').value.toString(),
        document.child('email').value.toString(),
        document.child('name').value.toString(),
        document.child('phoneNumber').value.toString()
    );
  }
}