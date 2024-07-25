import 'package:envirovista/profile_page.dart';
import 'package:envirovista/reduce_page.dart';
import 'package:envirovista/sign_in.dart';
import 'package:envirovista/sign_up.dart';
import 'package:envirovista/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EnviroVista());
}

class EnviroVista extends StatelessWidget {
  const EnviroVista({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
