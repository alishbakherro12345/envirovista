import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailInputScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  void sendPasswordResetEmail(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      // Proceed to the code verification screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CodeVerificationScreen(email: emailController.text)),
      );
    } catch (e) {
      print('Error sending password reset email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendPasswordResetEmail(context),
              child: Text('Send Code'),
            ),
          ],
        ),
      ),
    );
  }
}

class CodeVerificationScreen extends StatefulWidget {
  final String email;
  CodeVerificationScreen({required this.email});

  @override
  _CodeVerificationScreenState createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  final TextEditingController codeController = TextEditingController();

  void verifyCode(BuildContext context) {
    // Assume the code is '12345' for demo purposes
    if (codeController.text == '12345') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PasswordResetScreen(email: widget.email)),
      );
    } else {
      print('Invalid code');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Code')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: 'Verification Code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => verifyCode(context),
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}



class PasswordResetScreen extends StatelessWidget {
  final String email;
  final TextEditingController passwordController = TextEditingController();

  PasswordResetScreen({required this.email});

  void resetPassword(BuildContext context) async {
    try {
      User? user = (await FirebaseAuth.instance.signInWithEmailLink(email: email, emailLink: email)).user;
      if (user != null) {
        user.updatePassword(passwordController.text);
        // Navigate to login or home screen
        Navigator.popUntil(context, ModalRoute.withName('/'));
      }
    } catch (e) {
      print('Error resetting password: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => resetPassword(context),
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
