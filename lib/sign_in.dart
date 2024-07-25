import 'package:envirovista/forget_password.dart';
import 'package:envirovista/profile_page.dart';
import 'package:envirovista/roundbutton.dart';
import 'package:envirovista/sign_up.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisible = false;


  final _auth = FirebaseAuth.instance ;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text).then((value){
      showToast(value.user!.email.toString(),context:context);
      Navigator.push(context,MaterialPageRoute(builder: (context) => ProfilePage())
      );
      setState(() {
        loading = false;
      });

    }).onError((error,stackTrace){
      debugPrint(error.toString());
      showToast(error.toString(),context:context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffEEEEEE),
      body: Column(
        children: [
          const SizedBox(height: 150),
          const Center(
              child: Text(
            'Welcome Back!',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color(0xff2A3C24)),
          )),
          const Center(
              child: Text(
            'Sign In to your existent account of ',
            style: TextStyle(color: Color(0xffA7A7A7)),
          )),
          const Center(
              child: Text(
            'EnviroVista',
            style: TextStyle(color: Color(0xffA7A7A7)),
          )),
          const SizedBox(height: 80),
          Container(
            width: 330,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 320,
                      height: 60,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Color(0xff87A430)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Color(0xff87A430)),
                            ),
                            fillColor: Colors.black,
                            hintText: 'email',
                            //  cursorColor : Color(0xff87A430),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color(0xff87A430),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email is required';
                          }
                          return null;
                        },
                      ),
                    ), //email
                    const SizedBox(height: 20),
                    Container(
                      width: 320,
                      height: 60,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !_passwordVisible,
                        cursorColor: const Color(0xff87A430),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1.5, color: Color(0xff87A430)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            const BorderSide(color: Color(0xff87A430)),
                          ),
                          fillColor: Colors.black,
                          hintText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xff87A430),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password is required';
                          }
                          return null;
                        },
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EmailInputScreen()));
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                              color: Color(0xff2A3C24),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ) //forget password?
                  ],
                )),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/signin-1.jpg"),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                RoundButton(
                  title: 'SignIn',
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                      // Perform sign-in action
                    }
                  },
                ),
                const SizedBox(height: 110),
                Container(
                  width: 260,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't you have an account? ",
                        style: TextStyle(color: Color(0xff5A5A5A)),
                      ),
                      GestureDetector(
                        child: Container(
                            width: 55,
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                  color: Color(0xff2A3C24),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => SignUp()));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ), //Button
        ],
      ),
    );
  }
}
