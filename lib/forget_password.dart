import 'package:envirovista/roundbutton.dart';
import 'package:envirovista/sign_in.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      // Implement your reset password logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset link sent to ${emailController.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Icon(Icons.arrow_back_ios, size: 30),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) => SignIn()),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xff2A3C24),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Please enter your email to reset the password',
                        style: TextStyle(color: Color(0xff989898), fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: Container(
                    width: 320,
                    height: 60,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 1.5, color: Color(0xff87A430)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xff87A430)),
                        ),
                        hintText: 'Your Email',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff87A430),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: RoundButton(
                  title: 'Reset Password',
                  onTap: _resetPassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
