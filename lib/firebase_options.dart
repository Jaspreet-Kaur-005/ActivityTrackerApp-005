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
    apiKey: 'AIzaSyBIvZhjaP-6BhXndOVf_vOqADhAlkFy3l4',
    appId: '1:903301536942:web:1b0f91cdd2f8ce1efe613f',
    messagingSenderId: '903301536942',
    projectId: 'activity-tracker-app-2acf2',
    authDomain: 'activity-tracker-app-2acf2.firebaseapp.com',
    storageBucket: 'activity-tracker-app-2acf2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDI8xiPGrUCinb88BFDFVHyXTdtAizWeeQ',
    appId: '1:903301536942:android:56d3c9b83cf272d4fe613f',
    messagingSenderId: '903301536942',
    projectId: 'activity-tracker-app-2acf2',
    storageBucket: 'activity-tracker-app-2acf2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBF84m-0pL5ab4Y8rBdJ2kD6rtoMuBg2T4',
    appId: '1:903301536942:ios:3f61ee0244d1910efe613f',
    messagingSenderId: '903301536942',
    projectId: 'activity-tracker-app-2acf2',
    storageBucket: 'activity-tracker-app-2acf2.appspot.com',
    iosBundleId: 'com.example.activityTracerApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBF84m-0pL5ab4Y8rBdJ2kD6rtoMuBg2T4',
    appId: '1:903301536942:ios:a0c51ec918e3feddfe613f',
    messagingSenderId: '903301536942',
    projectId: 'activity-tracker-app-2acf2',
    storageBucket: 'activity-tracker-app-2acf2.appspot.com',
    iosBundleId: 'com.example.activityTracerApp.RunnerTests',
  );
}
