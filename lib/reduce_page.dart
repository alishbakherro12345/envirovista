import 'package:envirovista/activechallengescard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_page.dart';
import 'recommandes_challenges_card.dart';
import 'custom_bottom_nav_bar.dart';

class ReducePage extends StatefulWidget {
  @override
  State<ReducePage> createState() => _ReducePageState();
}

class _ReducePageState extends State<ReducePage> {
  late final String userId = FirebaseAuth.instance.currentUser!.uid;

  Stream<List<DocumentSnapshot>> _getActiveChallenges() {
    return FirebaseFirestore.instance.collection('challenges').snapshots().map((querySnapshot) {
      return querySnapshot.docs.where((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        return data != null && data.containsKey('users') && data['users']?[userId] == true;
      }).toList();
    });
  }

  Stream<List<DocumentSnapshot>> _getRecommendedChallenges() {
    return FirebaseFirestore.instance.collection('challenges').snapshots().map((querySnapshot) {
      return querySnapshot.docs.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFF0EF),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Center(
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, size: 30,),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
                    },
                  ),
                  SizedBox(width: 15),
                  Text('Reduce', style: TextStyle(color: Color(0xff2A3C24), fontSize: 25, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text('Active Challenges', style: TextStyle(color: Color(0xff87A430), fontSize: 20)),
              ),
            ),
            Container(
              height: 165,
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: _getActiveChallenges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Color(0xff66B630), strokeWidth: 2));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final activeChallenges = snapshot.data ?? [];
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: activeChallenges.map((doc) {
                          return ActiveChallengesCard(title: doc['title'], imagepath: doc['imagepath'], userId: userId); //Pass current user ID
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text('Recommended Challenges', style: TextStyle(color: Color(0xff87A430), fontSize: 20)),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: _getRecommendedChallenges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Color(0xff66B630), strokeWidth: 2));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final recommendedChallenges = snapshot.data ?? [];
                    return SingleChildScrollView(
                      child: Column(
                        children: _buildChallengeRows(recommendedChallenges),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 3),
    );
  }

  List<Widget> _buildChallengeRows(List<DocumentSnapshot> challenges) {
    List<Widget> rows = [];
    for (int i = 0; i < challenges.length; i += 2) {
      List<Widget> rowChildren = [];
      rowChildren.add(_buildChallengeCard(challenges[i]));
      if (i + 1 < challenges.length) {
        rowChildren.add(SizedBox(width: 12));
        rowChildren.add(_buildChallengeCard(challenges[i + 1]));
      }
      rows.add(Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          children: rowChildren,
        ),
      ));
    }
    return rows;
  }

  Widget _buildChallengeCard(DocumentSnapshot doc) {
    return RecommandesChallengesCard(
      title: doc['title'],
      imagepath: doc['imagepath'],
    );
  }
}
