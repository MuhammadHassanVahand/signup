import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signup/authentication/signin.dart';
import 'package:signup/customWidget/appText.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User? user;
  late String email = "";
  late String name = "";
  late String gender = "";
  late Timestamp dateOfBirth = Timestamp.now();
  late String phoneNumber = "";

  Future<void> fatchUserDate() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      final userData = await users.doc(currentUser.uid).get();

      setState(() {
        user = currentUser;
        name = userData["full name"] ?? "";
        email = userData["email"] ?? "";
        phoneNumber = userData["phone number"] ?? "";
        gender = userData["gender"] ?? "";
        dateOfBirth = userData["date of birth"] as Timestamp ?? Timestamp.now();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fatchUserDate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Home"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.cyanAccent,
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://t3.ftcdn.net/jpg/03/53/11/00/360_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg"),
                    radius: 30,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(name),
                ],
              ),
            ),
            ListTile(
              leading: const AppText(
                text: "Email:",
                size: 15,
              ),
              trailing: AppText(
                text: email,
                size: 15,
              ),
            ),
            ListTile(
              leading: const AppText(
                text: "Phone Number:",
                size: 15,
              ),
              trailing: AppText(
                text: phoneNumber,
                size: 15,
              ),
            ),
            ListTile(
              leading: const AppText(
                text: "Gender:",
                size: 15,
              ),
              trailing: AppText(
                text: gender,
                size: 15,
              ),
            ),
            ListTile(
              leading: const AppText(
                text: "Date Of Birth:",
                size: 15,
              ),
              trailing: AppText(
                text: DateFormat('yyyy-MM-dd').format(dateOfBirth.toDate()),
                size: 15,
              ),
            ),
            Container(
              child: ListTile(
                onTap: () async {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                title: AppText(text: "Sign out"),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
