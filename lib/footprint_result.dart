import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envirovista/foot_print_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FootprintData {
  final String section;
  final String value;

  FootprintData({required this.section, required this.value});

  factory FootprintData.fromMap(Map<String, dynamic> data, String section) {
    return FootprintData(
      section: section,
      value: data[section] ?? '0',
    );
  }
}

class FootprintResult extends StatefulWidget {
  const FootprintResult({super.key});

  @override
  State<FootprintResult> createState() => _FootprintResultState();
}

class _FootprintResultState extends State<FootprintResult> {
  bool loading = false;

  Stream<List<FootprintData>> fetchFootprintData() {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('Hosteller')
        .doc('Overall Results')
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        return data.entries.map((entry) {
          return FootprintData(section: entry.key, value: entry.value.toString());
        }).toList();
      } else {
        return [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffEFF0EF),
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
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => FootprintPage()));
                  },
                ),
                SizedBox(width: 15),
                Text(
                  'FootPrint',
                  style: TextStyle(
                      color: Color(0xff2A3C24),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: Color(0xffA1C34A),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black38,
                  )
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 35),
                    child: Text(
                      'Your Annual Carbon Footprint',
                      style: TextStyle(
                          color: Color(0xff2A3C24),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Text(
                      'Overall Results',
                      style: TextStyle(
                          color: Color(0xff2A3C24),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Color(0xffEFF0EF),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    child: StreamBuilder<List<FootprintData>>(
                      stream: fetchFootprintData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No data available'));
                        } else {
                          List<FootprintData> data = snapshot.data!;
                          return ListView.builder(
                            padding: EdgeInsets.zero, // Remove padding from ListView
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0), // Remove padding around ListTile
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                                  dense: true, // Make ListTile denser
                                  leading: Text(data[index].section, style: TextStyle(color: Colors.black)),
                                  trailing: Text(data[index].value, style: TextStyle(color: Colors.black)),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
