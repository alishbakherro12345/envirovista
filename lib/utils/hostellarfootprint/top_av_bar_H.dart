import 'package:flutter/material.dart';
class TopNavBarH extends StatelessWidget {
  final Color color1;
  final Color bar1;
  final Color color2;
  final Color bar2;
  final Color color3;
  final Color bar3;
  final Color color4;
  final Color bar4;
  final Color check;


  const TopNavBarH({super.key,required this.color1,required this.bar1,required this.color2,required this.bar2,required this.color3,required this.bar3,required this.color4,required this.bar4,required this.check});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 310,
        child: Row(
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
            ), //bar3
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: color4,
                  borderRadius: BorderRadius.circular(75),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black26,
                    )
                  ]

              ),
              child: Center(child: Text('4',style: TextStyle(color: Colors.black),)),
            ),//circle4
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: bar4,
                borderRadius: BorderRadius.circular(2),
              ),
            ), //bar4
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
        ),
      ),
    );
  }
}
