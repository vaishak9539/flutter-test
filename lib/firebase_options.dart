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
    apiKey: 'AIzaSyBzY3aZoKd35fTp3eYPVNlqxoBNX5A2Rn0',
    appId: '1:181999022182:web:46d7515e2009988c847da7',
    messagingSenderId: '181999022182',
    projectId: 'flutter-test-e37ad',
    authDomain: 'flutter-test-e37ad.firebaseapp.com',
    storageBucket: 'flutter-test-e37ad.appspot.com',
    measurementId: 'G-481WXWEGRP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUT_n3y3Wko3q2eDx6PxCS5thSiTEu3-8',
    appId: '1:181999022182:android:f2bbecac9b54fc9f847da7',
    messagingSenderId: '181999022182',
    projectId: 'flutter-test-e37ad',
    storageBucket: 'flutter-test-e37ad.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDespF6fNVHy2q-eYlAy7aC1RKzWNe7ae0',
    appId: '1:181999022182:ios:00c15f5702d401fa847da7',
    messagingSenderId: '181999022182',
    projectId: 'flutter-test-e37ad',
    storageBucket: 'flutter-test-e37ad.appspot.com',
    iosBundleId: 'com.example.fluttertest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDespF6fNVHy2q-eYlAy7aC1RKzWNe7ae0',
    appId: '1:181999022182:ios:00c15f5702d401fa847da7',
    messagingSenderId: '181999022182',
    projectId: 'flutter-test-e37ad',
    storageBucket: 'flutter-test-e37ad.appspot.com',
    iosBundleId: 'com.example.fluttertest',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBzY3aZoKd35fTp3eYPVNlqxoBNX5A2Rn0',
    appId: '1:181999022182:web:6b8ed0b70692c2ee847da7',
    messagingSenderId: '181999022182',
    projectId: 'flutter-test-e37ad',
    authDomain: 'flutter-test-e37ad.firebaseapp.com',
    storageBucket: 'flutter-test-e37ad.appspot.com',
    measurementId: 'G-LQ5W4ZEQNL',
  );
}