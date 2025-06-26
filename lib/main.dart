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
      apiKey: "AIzaSyDF8zpOC46WCJ3OZaHS4xYJppz_iNt-pPk", 
      appId: "1:523600901086:android:33685a8b65be0a2cfd234f", 
      messagingSenderId: "523600901086", 
      projectId: "hexagontm-7062a", 
      databaseURL: "https://hexagontm-7062a-default-rtdb.firebaseio.com", 
      storageBucket: "hexagontm-7062a.firebasestorage.app", 
    ),
  );

  // Initialize Notification Service

  runApp(const ProviderScope(child: TimingMattersApp()));
}
