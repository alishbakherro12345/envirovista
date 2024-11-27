import 'package:flutter/material.dart';

class LearnCard extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String imagepath;
  final Color cardcolor;

  const LearnCard({super.key,required this.text1,required this.text2,required this.text3,required this.imagepath,required this.cardcolor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            //width: 160,
            height: 175,
            child: Image.asset( imagepath,fit: BoxFit.fill,),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            //width: 192,
            height: 175,
            color: cardcolor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
              child: Column(
                children: [
                  Text( 'Did you know?' ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Text( text1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 8),),
                  Text( text2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 8),),
                  SizedBox(height: 20,),
                  Center(
                    child: Text( text3,style: TextStyle(fontSize: 8),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
