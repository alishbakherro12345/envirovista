import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'learn_card.dart';
import 'learn_top_nav_bar.dart';
import '../../profile_page.dart';
import '../../custom_bottom_nav_bar.dart';

class LearnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, size: 30, weight: 20),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
                    },
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Learn',
                    style: TextStyle(
                        color: Color(0xff2A3C24),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
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
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('learnCards').doc('card').collection('food').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                     // return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text('No data found');
                    }

                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: snapshot.data!.docs.map((doc) {
                          var data = doc.data() as Map<String, dynamic>;
                          return Column(
                            children: [
                              LearnCard(
                                cardcolor: Color(int.parse(data['cardcolor'] ?? '0xffCFEF83')),
                                imagepath: data['imagepath'] ?? 'images/foodcard-1.png',
                                text1: data['text1'] ?? '',
                                text2: data['text2'] ?? '',
                                text3: data['text3'] ?? '',
                              ),
                              SizedBox(height: 8),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}
class LearnPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, size: 30, weight: 20),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
                    },
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Learn',
                    style: TextStyle(
                        color: Color(0xff2A3C24),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
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
              Expanded(
                flex: 1,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('learnCards').doc('card').collection('car').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      //return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text('No data found');
                    }

                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: snapshot.data!.docs.map((doc) {
                          var data = doc.data() as Map<String, dynamic>;
                          return Column(
                            children: [
                              LearnCard(
                                cardcolor: Color(int.parse(data['cardcolor'] ?? '0xff83DCEF')),
                                imagepath: data['imagepath'] ?? 'images/foodcard-1.png',
                                text1: data['text1'] ?? '',
                                text2: data['text2'] ?? '',
                                text3: data['text3'] ?? '',
                              ),
                              SizedBox(height: 8),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}
class LearnPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, size: 30, weight: 20),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
                    },
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Learn',
                    style: TextStyle(
                        color: Color(0xff2A3C24),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
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
              Expanded(
                flex: 1,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('learnCards').doc('card').collection('home').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                     // return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text('No data found');
                    }

                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: snapshot.data!.docs.map((doc) {
                          var data = doc.data() as Map<String, dynamic>;
                          return Column(
                            children: [
                              LearnCard(
                                cardcolor: Color(int.parse(data['cardcolor'] ?? '0xffEF83BD')),
                                imagepath: data['imagepath'] ?? 'images/foodcard-1.png',
                                text1: data['text1'] ?? '',
                                text2: data['text2'] ?? '',
                                text3: data['text3'] ?? '',
                              ),
                              SizedBox(height: 8),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}
class LearnPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, size: 30, weight: 20),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
                    },
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Learn',
                    style: TextStyle(
                        color: Color(0xff2A3C24),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
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
              Expanded(
                flex: 1,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('learnCards').doc('card').collection('reduce').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      //return CircularProgressIndicator(color: Colors.green,);
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text('No data found');
                    }

                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: snapshot.data!.docs.map((doc) {
                          var data = doc.data() as Map<String, dynamic>;
                          return Column(
                            children: [
                              LearnCard(
                                cardcolor: Color(int.parse(data['cardcolor'] ?? '0xffE8D052')),
                                imagepath: data['imagepath'] ?? 'images/foodcard-1.png',
                                text1: data['text1'] ?? '',
                                text2: data['text2'] ?? '',
                                text3: data['text3'] ?? '',
                              ),
                              SizedBox(height: 8),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}











