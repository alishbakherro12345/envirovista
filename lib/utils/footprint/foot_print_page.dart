import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../custom_bottom_nav_bar.dart';
import 'package:envirovista/utils/dailyschoolarfootprint/foot_print_1.dart';
import 'package:envirovista/utils/hostellarfootprint/foot_print_H0.dart';
import 'package:envirovista/profile_page.dart';

class FootprintPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _checkAndDeleteHostellerDocuments(BuildContext context) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Get the Hosteller collection reference for the current user
      CollectionReference hostellerCollection = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('Footprint');

      // Get all documents from the Hosteller collection
      QuerySnapshot snapshot = await hostellerCollection.get();

      // Check if the collection is not empty
      if (snapshot.docs.isNotEmpty) {
        // Delete each document in the collection
        for (DocumentSnapshot doc in snapshot.docs) {
          await doc.reference.delete();
        }
      }

      // Navigate to FootPrintH0 page after deletion
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (BuildContext context) => FootPrintH0()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    weight: 20,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (BuildContext context) => ProfilePage()),
                    );
                  },
                ),
                SizedBox(width: 15),
                Text(
                  'FootPrint',
                  style: TextStyle(
                      color: Color(0xff2A3C24),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 150),
            Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    color: Color(0xff87A430),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black38,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 20),
                  child: Column(
                    children: [
                      Text(
                        'In order to assess your carbon footprint'
                            ' accurately, could you specify if you'
                            ' primarily reside in university'
                            ' accommodation (hostel) or commute daily'
                            ' as a scholar? ',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xffECEBEB),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20,
                                color: Colors.black26,
                              )
                            ],
                          ),
                          child: Center(child: Text('Hostellers')),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FootPrintH0()),
                          );
                          // Call the function to check and delete documents, then navigate
                          _checkAndDeleteHostellerDocuments(context);
                        },
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xffECEBEB),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.black12,
                                )
                              ]),
                          child: Center(child: Text('Daily Scholars')),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FootPrint1()),
                          );
                            // Call the function to check and delete documents, then navigate
                            _checkAndDeleteHostellerDocuments(context);
                        },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 1),
    );
  }
}
