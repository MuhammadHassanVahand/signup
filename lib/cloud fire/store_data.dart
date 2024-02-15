import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  final String fullName;
  final String email;
  final DateTime dateOfBirth;
  final int phoneNumber;
  final String gender;

  AddUser(
    this.fullName,
    this.email,
    this.dateOfBirth,
    this.phoneNumber,
    this.gender,
  );

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'full name': fullName, //
            'email': email,
            'phone number': phoneNumber,
            'date of birth': dateOfBirth,
            'gender': gender,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}
