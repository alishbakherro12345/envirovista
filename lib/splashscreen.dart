import 'package:envirovista/introscreen.dart';
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
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 5), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const IntroScreen1()));
    });
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
              child: Image(image: AssetImage('images/logo-1.png'))),
        ),
        ),
    );
  }
}
