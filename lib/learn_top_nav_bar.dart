import 'package:envirovista/learn_page.dart';
import 'package:flutter/material.dart';

class LearnTopNavBar extends StatelessWidget {
  final Color foodcolor;
  final Color carcolor;
  final Color homecolor;
  final Color reducecolor;

  const LearnTopNavBar({super.key,required this.foodcolor,required this.carcolor,required this.homecolor,required this.reducecolor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 31,right: 31,top: 15),
      child: Row(
        children: [
          Column(
            children: [
              GestureDetector(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xffCFEF83),
                      borderRadius: BorderRadius.circular(75),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          color: Colors.black26,
                        )
                      ]
                  ),
                  child: Image.asset('images/food-1.png'),
                ),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> LearnPage()));
                },
              ),
              SizedBox(height: 5),
              Container(
                width: 65,
                height: 6,
                decoration: BoxDecoration(
                    color: foodcolor,
                  borderRadius: BorderRadius.circular(15),
                ),
              )
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: [
              GestureDetector(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xff83DCEF),
                      borderRadius: BorderRadius.circular(75),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          color: Colors.black26,
                        )
                      ]
                  ),
                  child: Image.asset('images/car-1.png'),
                ),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> LearnPage1()));
                },
              ),
              SizedBox(height: 5),
              Container(
                width: 65,
                height: 6,
                decoration: BoxDecoration(
                  color: carcolor,
                  borderRadius: BorderRadius.circular(15),
                ),
              )
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: [
              GestureDetector(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xffEF83BD),
                      borderRadius: BorderRadius.circular(75),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          color: Colors.black26,
                        )
                      ]
                  ),
                  child: Image.asset('images/home-1.png'),
                ),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> LearnPage2()));
                },

              ),
              SizedBox(height: 5),
              Container(
                width: 65,
                height: 6,
                decoration: BoxDecoration(
                  color: homecolor,
                  borderRadius: BorderRadius.circular(15),
                ),
              )
            ],
          ),
          SizedBox(width: 8),
          Column(
            children: [
              GestureDetector(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xffE8D052),
                      borderRadius: BorderRadius.circular(75),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          color: Colors.black26,
                        )
                      ]
                  ),
                  child: Image.asset('images/reduce-1.png'),
                ),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> LearnPage3()));
                },
              ),
              SizedBox(height: 5),
              Container(
                width: 65,
                height: 6,
                decoration: BoxDecoration(
                  color: reducecolor,
                  borderRadius: BorderRadius.circular(15),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
