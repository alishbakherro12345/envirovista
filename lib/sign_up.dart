import 'package:envirovista/roundbutton.dart';
import 'package:envirovista/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';  // Add this import for date formatting

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final departmentController = TextEditingController();
  final rollnoController = TextEditingController();
  final gradeController = TextEditingController();
  final genderController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    dobController.dispose();
    departmentController.dispose();
    rollnoController.dispose();
    gradeController.dispose();
    genderController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime(2000);
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2009, 12, 31);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != initialDate)
      setState(() {
        dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
       // backgroundColor: Color(0xffEEEEEE),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/signup-1.png"),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Center(
                      child: Text(
                        'Let’s Get Started!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xff2A3C24)),
                      ),
                    ),
                    Center(
                      child: Text(
                        'create an account to EnviroVista to get',
                        style: TextStyle(color: Color(0xffA7A7A7)),
                      ),
                    ),
                    Center(
                      child: Text(
                        'carbon footprint evaluation',
                        style: TextStyle(color: Color(0xffA7A7A7)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Form(
                  key: _formkey,
                  child: Container(
                    height: 480,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Container(
                            width: 320,
                            height: 60,
                            child: TextFormField(
                              controller: usernameController,
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
                                hintText: 'Username',
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Color(0xff87A430),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'username is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
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
                                hintText: 'Email',
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Color(0xff87A430),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'email is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 320,
                            height: 60,
                            child: TextFormField(
                              controller: dobController,
                              keyboardType: TextInputType.datetime,
                              readOnly: true,
                              onTap: () => _selectDate(context),
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
                                hintText: 'Date of birth',
                                prefixIcon: const Icon(
                                  Icons.calendar_month,
                                  color: Color(0xff87A430),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'date of birth is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 320,
                            height: 60,
                            child: TextFormField(
                              controller: departmentController,
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
                                hintText: 'Department',
                                prefixIcon: const Icon(
                                  Icons.home_work_rounded,
                                  color: Color(0xff87A430),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'department is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 320,
                            height: 60,
                            child: TextFormField(
                              controller: rollnoController,
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
                                hintText: 'Student Roll no',
                                prefixIcon: const Icon(
                                    Icons.card_membership,
                                    color: Color(0xff87A430)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Student Roll no is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 320,
                            height: 60,
                            child: DropdownButtonFormField<String>(
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
                                hintText: 'Grade',
                                prefixIcon: const Icon(
                                    Icons.grade,
                                    color: Color(0xff87A430)),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: 'Under-graduate',
                                  child: Text('Under-graduate'),
                                ),
                                DropdownMenuItem(
                                  value: 'Masters',
                                  child: Text('Masters'),
                                ),
                                DropdownMenuItem(
                                  value: 'Doctorate/PhD',
                                  child: Text('Doctorate/PhD'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  gradeController.text = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Grade is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 320,
                            height: 60,
                            child: DropdownButtonFormField<String>(
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
                                hintText: 'Gender',
                                prefixIcon: const Icon(
                                    Icons.group_add,
                                    color: Color(0xff87A430)),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: 'Female',
                                  child: Text('Female'),
                                ),
                                DropdownMenuItem(
                                  value: 'Male',
                                  child: Text('Male'),
                                ),
                                DropdownMenuItem(
                                  value: 'Other',
                                  child: Text('Other'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  genderController.text = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Gender is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          Container(
                            width: 320,
                            height: 60,
                            child: TextFormField(
                              controller: confirmpasswordController,
                              obscureText: !_confirmPasswordVisible,
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
                                hintText: 'Confirm password',
                                prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Color(0xff87A430)),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _confirmPasswordVisible = !_confirmPasswordVisible;
                                    });
                                  },
                                  child: Icon(
                                    _confirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'confirm password is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          RoundButton(
                            title: 'SignUp',
                            loading: loading,
                            onTap: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                UserCredential userCredential =
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                    email: emailController.text
                                        .toString(),
                                    password: passwordController.text
                                        .toString());
                                String uid = userCredential.user!.uid; // Get the user ID
                                setState(() {
                                  loading = false;
                                });
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(uid)
                                    .set({
                                  'uid': uid, // Add the user ID to the data
                                  'name': usernameController.text,
                                  'email': emailController.text,
                                  'DOB': dobController.text,
                                  'department': departmentController.text,
                                  'rollno': rollnoController.text,
                                  'grade': gradeController.text,
                                  'gender': genderController.text,
                                  'nickname':'nickname',
                                });
                                setState(() {
                                  loading = false;
                                });
                                showToast('User Registered Successfully',
                                    context: context);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SignIn()));
                              }
                              // Perform sign-up action
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 260,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: Color(0xff5A5A5A)),
                      ),
                      GestureDetector(
                        child: Container(
                          width: 50,
                          child: Text(
                            'SignIn',
                            style: TextStyle(
                                color: Color(0xff2A3C24),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => SignIn()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





