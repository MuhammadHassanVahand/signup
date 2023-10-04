// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDmX_larUCBg13prlrgIk6aNa_yRh7wsZU',
    appId: '1:262664393983:web:180c15f60b6b0ae2f568ca',
    messagingSenderId: '262664393983',
    projectId: 'signup-988b9',
    authDomain: 'signup-988b9.firebaseapp.com',
    storageBucket: 'signup-988b9.appspot.com',
    measurementId: 'G-DPX993JQSZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgfrF-ZP9debFcdqpuIsMbVSgTAbiY-dU',
    appId: '1:262664393983:android:1fee9a813b07063ff568ca',
    messagingSenderId: '262664393983',
    projectId: 'signup-988b9',
    storageBucket: 'signup-988b9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtJT8qFqpSP5bOgZMDOjHekZHvUmZMk1c',
    appId: '1:262664393983:ios:8c1d8634c3524f5df568ca',
    messagingSenderId: '262664393983',
    projectId: 'signup-988b9',
    storageBucket: 'signup-988b9.appspot.com',
    iosBundleId: 'com.example.signup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtJT8qFqpSP5bOgZMDOjHekZHvUmZMk1c',
    appId: '1:262664393983:ios:84b64b52cd47f690f568ca',
    messagingSenderId: '262664393983',
    projectId: 'signup-988b9',
    storageBucket: 'signup-988b9.appspot.com',
    iosBundleId: 'com.example.signup.RunnerTests',
  );
}