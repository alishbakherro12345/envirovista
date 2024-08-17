import 'package:flutter/material.dart';
class Rewardpointsaward extends StatelessWidget {
  final String title;
  final String points;

  const Rewardpointsaward({super.key,required this.title,required this.points});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black26,
            )
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6,bottom: 6),
              child: ListTile(
                leading: Container(
                  height: 70,
                  width: 70,
                  child: Image(image: AssetImage('images/budge-1.png'),fit: BoxFit.fill,),) ,
                subtitle: Row(
                  children: [
                    Text(title,style: TextStyle(color: Color(0xff646464),fontSize: 12),),
                  ],
                ),
                trailing: Container(
                  height: 30,
                  width: 70,
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                      color: Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          color: Colors.black26,
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                    child: Row(
                      children: [
                        Text(points,style: TextStyle(color: Color(0xff253010),fontSize: 12,fontWeight: FontWeight.bold),),
                        SizedBox(width: 5),
                        Image(image: AssetImage('images/coin-1.png')),
                      ],
                    ),
                  ),
                ),
                title: Text('Milestone Achieved',style: TextStyle(color: Color(0xff0D1E26),fontWeight: FontWeight.bold,fontSize: 14),),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
