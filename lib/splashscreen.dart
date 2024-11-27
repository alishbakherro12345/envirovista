import 'package:envirovista/introscreen.dart';
import 'package:envirovista/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Check if user is already logged in
    Future.delayed(const Duration(seconds: 2), () {
      _checkLoginStatus();
    });
  }

  // Method to check if the user is logged in
  void _checkLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser; // Get the current user
    if (user != null) {
      // User is signed in, navigate to Profile Screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ProfilePage()),
      );
    } else {
      // User is not signed in, navigate to IntroScreen (login screen)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const IntroScreen1()),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff010B15), Color(0xff132229)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            width: 250,
            child: const Image(image: AssetImage('images/logo-1.png')),
          ),
        ),
      ),
    );
  }
}

