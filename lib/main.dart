import 'package:activity_tracer_app/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDI8xiPGrUCinb88BFDFVHyXTdtAizWeeQ",
      projectId: "activity-tracker-app-2acf2",
      storageBucket: "activity-tracker-app-2acf2.appspot.com",
      messagingSenderId: "903301536942",
      appId: "1:903301536942:android:9dba89f6a9468d8efe613f",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Activities Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
