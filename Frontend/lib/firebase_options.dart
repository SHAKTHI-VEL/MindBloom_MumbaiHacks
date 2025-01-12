// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDL70iQo1i-Zu6reor5YFd3wHC5IYJTRA8',
    appId: '1:897663417109:web:41dba6bd3a98bb3f45c71c',
    messagingSenderId: '897663417109',
    projectId: 'mindbloom-e29e2',
    authDomain: 'mindbloom-e29e2.firebaseapp.com',
    storageBucket: 'mindbloom-e29e2.appspot.com',
    measurementId: 'G-P0H60KNG5M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCiRWUZppO-T4_FW05bFaLFVB81zTLydXg',
    appId: '1:897663417109:android:4d4076131dd9b0e745c71c',
    messagingSenderId: '897663417109',
    projectId: 'mindbloom-e29e2',
    storageBucket: 'mindbloom-e29e2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxdjRqxIU4CuNDn6cQ9w7sGCkkL1EHlcY',
    appId: '1:897663417109:ios:6aa0143db49161f345c71c',
    messagingSenderId: '897663417109',
    projectId: 'mindbloom-e29e2',
    storageBucket: 'mindbloom-e29e2.appspot.com',
    iosClientId: '897663417109-7pacc9nvg1s1if51oak2rfg7lu33o4lf.apps.googleusercontent.com',
    iosBundleId: 'com.example.mindbloom',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBxdjRqxIU4CuNDn6cQ9w7sGCkkL1EHlcY',
    appId: '1:897663417109:ios:6aa0143db49161f345c71c',
    messagingSenderId: '897663417109',
    projectId: 'mindbloom-e29e2',
    storageBucket: 'mindbloom-e29e2.appspot.com',
    iosClientId: '897663417109-7pacc9nvg1s1if51oak2rfg7lu33o4lf.apps.googleusercontent.com',
    iosBundleId: 'com.example.mindbloom',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDL70iQo1i-Zu6reor5YFd3wHC5IYJTRA8',
    appId: '1:897663417109:web:a73308f1463cfafd45c71c',
    messagingSenderId: '897663417109',
    projectId: 'mindbloom-e29e2',
    authDomain: 'mindbloom-e29e2.firebaseapp.com',
    storageBucket: 'mindbloom-e29e2.appspot.com',
    measurementId: 'G-FC0694LC1D',
  );
}
