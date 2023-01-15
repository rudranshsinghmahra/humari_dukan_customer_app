import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:humari_dukan/screens/home_screen.dart';
import 'package:humari_dukan/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;
    return MaterialApp(
      home: isLoggedIn ? const HomeScreen() : const OnBoardingScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xffff4a85)),
    );
  }
}
