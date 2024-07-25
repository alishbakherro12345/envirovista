import 'package:envirovista/introscreentwo.dart';
import 'package:flutter/material.dart';
class IntroScreen1 extends StatefulWidget {
  const IntroScreen1({super.key});

  @override
  State<IntroScreen1> createState() => _IntroScreen1State();
}

class _IntroScreen1State extends State<IntroScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 200),
          Center(
            child: Container(
              width: 280,
                  child: const Center(child: Image(image: AssetImage('images/info-1.png'))),
            ),),
          SizedBox(height: 50),
          GestureDetector(
            child: Center(
              child: Container(
                  width: 110,
                  child: const Row( children: [ Text('Continue',style: TextStyle(color: Color(0xff87A430),fontSize: 18),), Icon(Icons.double_arrow,color: Color(0xff87A430),)],)
              ),
            ),
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> Introscreen2()));
            },
          )

        ],
      ),
    );
  }
}
