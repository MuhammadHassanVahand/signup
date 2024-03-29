import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup/firebase_options.dart';
import 'package:signup/screens/api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final savedEmail = prefs.getString("userEmail");
  final isLoggedIn = FirebaseAuth.instance.currentUser != null;
  runApp(MyApp(
    prefs: prefs,
    savedEmail: savedEmail,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final String? savedEmail;
  final bool isLoggedIn;
  const MyApp(
      {super.key,
      required this.prefs,
      this.savedEmail,
      required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: isLoggedIn ? HomeScreen() : LoginScreen(savedEmail: savedEmail),
      home: API(),
    );
  }
}
