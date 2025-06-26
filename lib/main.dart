import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBMYRsnkEAaKJM661Q8vPROW4aI3r6Gd9Q",
      appId: "1:664950467657:android:890766958a62fc1eb1e398",
      messagingSenderId: "664950467657",
      projectId: "timmingmatters",
      databaseURL: "https://timmingmatters-default-rtdb.firebaseio.com ",
      storageBucket: "timmingmatters.firebasestorage.app",
    ),
  );

  // Initialize Notification Service

  runApp(const ProviderScope(child: TimingMattersApp()));
}
