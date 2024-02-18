import 'package:ahsan_online_bazar/screens/dashboard_screen.dart';
import 'package:ahsan_online_bazar/screens/login_screen.dart';
import 'package:ahsan_online_bazar/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyAJ18X4_0uuqEqPIeJv2pwSWpCjaUmxzX0',
        appId: '1:858765239468:android:f9fb95ca63cee2d497eb09',
        messagingSenderId: '858765239468',
        projectId: 'ahsan-online-bazar',
        storageBucket: 'ahsan-online-bazar.appspot.com',

    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}
