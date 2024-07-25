import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecommandesChallengesCard extends StatefulWidget {
  final String title;
  final String imagepath;

  const RecommandesChallengesCard({
    Key? key,
    required this.title,
    required this.imagepath,
  }) : super(key: key);

  @override
  _RecommandesChallengesCardState createState() => _RecommandesChallengesCardState();
}

class _RecommandesChallengesCardState extends State<RecommandesChallengesCard> {
  late bool isActive;
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    _loadChallengeStatus();
  }

  Future<void> _loadChallengeStatus() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('challenges').doc(widget.title).get();
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    setState(() {
      isActive = data?['users']?[userId] ?? false;
    });
  }

  Future<void> _toggleIsActiveStatus() async {
    if (!isActive) {
      setState(() {
        isActive = true;
      });

      final documentRef = FirebaseFirestore.instance.collection('challenges').doc(widget.title);

      await documentRef.set({
        'users': {userId: true}
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('challenges').doc(widget.title).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: Color(0xff66B630));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var data = snapshot.data!.data() as Map<String, dynamic>;
          isActive = data['users']?[userId] ?? false;

          return Expanded(
            flex: 1,
            child: Container(
              // width: 150,
              height: 170,
              decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Color(0xff66B630),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12, top: 22),
                child: Column(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.topLeft,
                      child: Image(image: AssetImage(widget.imagepath)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        await _toggleIsActiveStatus();
                      },
                      child: Container(
                        width: 150,
                        height: 35,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Color(0xff2A3C24),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: isActive
                              ? Icon(Icons.check, color: Colors.white)
                              : Text(
                            'Join Challenge',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(); // Return an empty container if there's no data
        }
      },
    );
  }
}




