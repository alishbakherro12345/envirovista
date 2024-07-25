import 'package:envirovista/learn_card.dart';
import 'package:envirovista/learn_top_nav_bar.dart';
import 'package:envirovista/profile_page.dart';
import 'package:flutter/material.dart';
import 'custom_bottom_nav_bar.dart';

class LearnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, size: 30, weight: 20,),
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> ProfilePage()));
                    },
                  ),
                  SizedBox(width: 15),
                  Text('Learn',style: TextStyle(color: Color(0xff2A3C24),fontSize: 25,fontWeight: FontWeight.bold),)
                ],
              ),
              SizedBox(height: 15),
              LearnTopNavBar(
                  foodcolor: Color(0xffCFEF83),
                  carcolor: Color(0xffD9D9D9),
                  homecolor: Color(0xffD9D9D9),
                  reducecolor: Color(0xffD9D9D9),
                ),
              SizedBox(height: 25),
              Expanded(
                flex: 1,
                child: Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        LearnCard(
                          cardcolor: Color(0xffCFEF83),
                          imagepath: 'images/foodcard-1.png',
                          text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                          text2: 'YOUR CARBON FOOTPRINT.',
                          text3: 'Restaurant food has a larger environmental footprint than home-cooked meals due to overhead emissions from heating, lighting, and cooking. Takeaway food adds to this with extra packaging and transport emissions from restaurant to home.',
                        ),
                        SizedBox(height: 8),
                        LearnCard(
                          cardcolor: Color(0xffCFEF83),
                          imagepath: 'images/foodcard-2.png',
                          text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                          text2: 'YOUR CARBON FOOTPRINT.',
                          text3: 'A large proportion of greenhouse gas emissions comes from food production, and meat and dairy are associated with much higher carbon emissions than plant-based food.',
                        ),
                        SizedBox(height: 8),
                        LearnCard(
                          cardcolor: Color(0xffCFEF83),
                          imagepath: 'images/foodcard-3.png',
                          text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                          text2: 'YOUR CARBON FOOTPRINT.',
                          text3: 'One third of all food produced is wasted. Every year wasted food in the UK represents 14 million tonnes of carbon dioxide emissions. In total, these greenhouse gas emissions are the same as those created by 7 million cars each year.',
                        ),
                        SizedBox(height: 8),
                        LearnCard(
                          cardcolor: Color(0xffCFEF83),
                          imagepath: 'images/foodcard-4.png',
                          text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                          text2: 'YOUR CARBON FOOTPRINT.',
                          text3: 'Buying local and seasonal food often has a lower environmental footprint due to reduced transport and packaging. However, responsibly sourced food from abroad can support developing countries and sustainable practices. Choose wisely for a positive impact.',
                        ),
                        SizedBox(height: 8),
                        LearnCard(
                          cardcolor: Color(0xffCFEF83),
                          imagepath: 'images/foodcard-5.png',
                          text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                          text2: 'YOUR CARBON FOOTPRINT.',
                          text3: 'Restaurant food has a larger environmental footprint than home-cooked meals due to overhead emissions from heating, lighting, and cooking. Takeaway food adds to this with extra packaging and transport emissions from restaurant to home.',
                        ),
                      ],),
                  ),
                ),
              ),
            ],
          ),
        ),),

      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}

class LearnPage1 extends StatelessWidget {
  const LearnPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, size: 30, weight: 20,),
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> ProfilePage()));
                    },
                  ),
                  SizedBox(width: 15),
                  Text('Learn',style: TextStyle(color: Color(0xff2A3C24),fontSize: 25,fontWeight: FontWeight.bold),)
                ],
              ),
              SizedBox(height: 15),
              LearnTopNavBar(
                foodcolor: Color(0xffD9D9D9),
                carcolor: Color(0xff83DCEF),
                homecolor: Color(0xffD9D9D9),
                reducecolor: Color(0xffD9D9D9),
              ),
              SizedBox(height: 25),
              Container(
                height: 533,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      LearnCard(
                        cardcolor: Color(0xff83DCEF),
                        imagepath: 'images/foodcard-1.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'Restaurant food has a larger environmental footprint than home-cooked meals due to overhead emissions from heating, lighting, and cooking. Takeaway food adds to this with extra packaging and transport emissions from restaurant to home.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xff83DCEF),
                        imagepath: 'images/foodcard-2.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'A large proportion of greenhouse gas emissions comes from food production, and meat and dairy are associated with much higher carbon emissions than plant-based food.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xff83DCEF),
                        imagepath: 'images/foodcard-3.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'One third of all food produced is wasted. Every year wasted food in the UK represents 14 million tonnes of carbon dioxide emissions. In total, these greenhouse gas emissions are the same as those created by 7 million cars each year.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xff83DCEF),
                        imagepath: 'images/foodcard-4.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'Buying local and seasonal food often has a lower environmental footprint due to reduced transport and packaging. However, responsibly sourced food from abroad can support developing countries and sustainable practices. Choose wisely for a positive impact.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xff83DCEF),
                        imagepath: 'images/foodcard-5.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'Restaurant food has a larger environmental footprint than home-cooked meals due to overhead emissions from heating, lighting, and cooking. Takeaway food adds to this with extra packaging and transport emissions from restaurant to home.',
                      ),
                    ],),
                ),
              ),
            ],
          ),
        ),),

      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}

class LearnPage2 extends StatelessWidget {
  const LearnPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, size: 30, weight: 20,),
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> ProfilePage()));
                    },
                  ),
                  SizedBox(width: 15),
                  Text('Learn',style: TextStyle(color: Color(0xff2A3C24),fontSize: 25,fontWeight: FontWeight.bold),)
                ],
              ),
              SizedBox(height: 15),
              LearnTopNavBar(
                foodcolor: Color(0xffD9D9D9),
                carcolor: Color(0xffD9D9D9),
                homecolor: Color(0xffEF83BD),
                reducecolor: Color(0xffD9D9D9),
              ),
              SizedBox(height: 25),
              Container(
                height: 533,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      LearnCard(
                        cardcolor: Color(0xffEF83BD),
                        imagepath: 'images/foodcard-1.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'Restaurant food has a larger environmental footprint than home-cooked meals due to overhead emissions from heating, lighting, and cooking. Takeaway food adds to this with extra packaging and transport emissions from restaurant to home.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xffEF83BD),
                        imagepath: 'images/foodcard-2.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'A large proportion of greenhouse gas emissions comes from food production, and meat and dairy are associated with much higher carbon emissions than plant-based food.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xffEF83BD),
                        imagepath: 'images/foodcard-3.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'One third of all food produced is wasted. Every year wasted food in the UK represents 14 million tonnes of carbon dioxide emissions. In total, these greenhouse gas emissions are the same as those created by 7 million cars each year.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xffEF83BD),
                        imagepath: 'images/foodcard-4.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'Buying local and seasonal food often has a lower environmental footprint due to reduced transport and packaging. However, responsibly sourced food from abroad can support developing countries and sustainable practices. Choose wisely for a positive impact.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xffEF83BD),
                        imagepath: 'images/foodcard-5.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'Restaurant food has a larger environmental footprint than home-cooked meals due to overhead emissions from heating, lighting, and cooking. Takeaway food adds to this with extra packaging and transport emissions from restaurant to home.',
                      ),
                    ],),
                ),
              ),
            ],
          ),
        ),),

      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}

class LearnPage3 extends StatelessWidget {
  const LearnPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, size: 30, weight: 20,),
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> ProfilePage()));
                    },
                  ),
                  SizedBox(width: 15),
                  Text('Learn',style: TextStyle(color: Color(0xff2A3C24),fontSize: 25,fontWeight: FontWeight.bold),)
                ],
              ),
              SizedBox(height: 15),
              LearnTopNavBar(
                foodcolor: Color(0xffD9D9D9),
                carcolor: Color(0xffD9D9D9),
                homecolor: Color(0xffD9D9D9),
                reducecolor: Color(0xffE8D052),
              ),
              SizedBox(height: 25),
              Container(
                height: 533,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      LearnCard(
                        cardcolor: Color(0xffE8D052),
                        imagepath: 'images/foodcard-1.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'Restaurant food has a larger environmental footprint than home-cooked meals due to overhead emissions from heating, lighting, and cooking. Takeaway food adds to this with extra packaging and transport emissions from restaurant to home.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xffE8D052),
                        imagepath: 'images/foodcard-2.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'A large proportion of greenhouse gas emissions comes from food production, and meat and dairy are associated with much higher carbon emissions than plant-based food.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xffE8D052),
                        imagepath: 'images/foodcard-3.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'One third of all food produced is wasted. Every year wasted food in the UK represents 14 million tonnes of carbon dioxide emissions. In total, these greenhouse gas emissions are the same as those created by 7 million cars each year.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xffE8D052),
                        imagepath: 'images/foodcard-4.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'Buying local and seasonal food often has a lower environmental footprint due to reduced transport and packaging. However, responsibly sourced food from abroad can support developing countries and sustainable practices. Choose wisely for a positive impact.',
                      ),
                      SizedBox(height: 8),
                      LearnCard(
                        cardcolor: Color(0xffE8D052),
                        imagepath: 'images/foodcard-5.png',
                        text1: 'YOUR DIET IS AN IMPORTANT PART OF',
                        text2: 'YOUR CARBON FOOTPRINT.',
                        text3: 'Restaurant food has a larger environmental footprint than home-cooked meals due to overhead emissions from heating, lighting, and cooking. Takeaway food adds to this with extra packaging and transport emissions from restaurant to home.',
                      ),
                    ],),
                ),
              ),
            ],
          ),
        ),),

      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}








