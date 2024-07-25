import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthStateProvider with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;

  void register(String email, String password, String username, BuildContext context) async {
    try {
      UserCredential userCred = await authInstance.createUserWithEmailAndPassword(email: email, password: password);
      await userCred.user!.updateDisplayName(username);
    } catch (e) {
      print(e);
    }
  }

  void logIn(String email, String password, BuildContext context) async {
    try {
      await authInstance.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  void logOut() async {
    await authInstance.signOut();
    notifyListeners();
  }
}