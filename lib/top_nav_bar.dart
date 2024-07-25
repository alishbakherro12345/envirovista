import 'package:flutter/material.dart';
class TopNavBar extends StatelessWidget {
  final Color color1;
  final Color bar1;
  final Color color2;
  final Color bar2;
  final Color color3;
  final Color bar3;
  final Color check;


  const TopNavBar({super.key,required this.color1,required this.bar1,required this.color2,required this.bar2,required this.color3,required this.bar3,required this.check});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color1,
            borderRadius: BorderRadius.circular(75),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black26,
                )
              ]
          ),
          child: Center(child: Text('1',style: TextStyle(color: Colors.black),)),
        ),//circle1
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: bar1,
            borderRadius: BorderRadius.circular(2),
          ),
        ),//bar1
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color2,
            borderRadius: BorderRadius.circular(75),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black26,
                )
              ]

          ),
          child: Center(child: Text('2',style: TextStyle(color: Colors.black),)),
        ),//circle2
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: bar2,
            borderRadius: BorderRadius.circular(2),
          ),
        ),//bar2
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color3,
            borderRadius: BorderRadius.circular(75),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black26,
                )
              ]

          ),
          child: Center(child: Text('3',style: TextStyle(color: Colors.black),)),
        ),//circle3
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: bar3,
            borderRadius: BorderRadius.circular(2),
          ),
        ),//bar3
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: check,
            borderRadius: BorderRadius.circular(75),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black26,
                )
              ]
          ),
          child: Center(child: Icon(Icons.check, color: Colors.black, size: 15,)),
        ),//check
      ],
    );
  }
}
