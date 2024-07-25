import 'package:envirovista/introscreen.dart';
import 'package:envirovista/sign_in.dart';
import 'package:envirovista/sign_up.dart';
import 'package:flutter/material.dart';

class Introscreen2 extends StatefulWidget {
  const Introscreen2({super.key});

  @override
  State<Introscreen2> createState() => _Introscreen2State();
}

class _Introscreen2State extends State<Introscreen2> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          SizedBox(height: 200),
          Center(
            child: Container(
              width: 280,
              child: const Center(child: Image(image: AssetImage('images/info-2.png'))),
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            child: Center(
              child: Container(
                  width: 110,
                  child: const Row( children: [ Text('Continue',style: TextStyle(color: Color(0xff87A430),fontSize: 18),), Icon(Icons.double_arrow,color: Color(0xff87A430),)],)
              ),
            ),
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> SignIn()));
            },
          )

        ],
      ),
    );
  }
}
