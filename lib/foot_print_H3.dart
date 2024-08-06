import 'package:envirovista/foot_print_1.dart';
import 'package:envirovista/foot_print_2.dart';
import 'package:envirovista/foot_print_H2.dart';
import 'package:envirovista/foot_print_H4.dart';
import 'package:envirovista/top_av_bar_H.dart';
import 'package:flutter/material.dart';
import 'package:envirovista/roundbutton.dart';
import 'package:envirovista/top_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'custom_bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/footprintsectionmodel.dart';

class FootPrintH3 extends StatefulWidget {
  const FootPrintH3({super.key});

  @override
  State<FootPrintH3> createState() => _FootPrintH3State();
}

class _FootPrintH3State extends State<FootPrintH3> {

  bool loading = false;

  String _selectedValue1 = 'Daily';
  String _selectedValue2 = 'Course-related materials(e.g, assignments, notes)';
  String _selectedValue3 = 'Always';
  String _selectedValue4 = 'Yes';
  String _selectedValue5 = '1-10 pages';


  List<String> _question1 = ['Daily', 'Several times a day', 'Once a week','Once a month','Rarely or never'];
  List<String> _question2 = ['Course-related materials(e.g, assignments, notes)', 'Personal documents','Research papers'];
  List<String> _question3 = ['Always', 'Sometimes', 'Rarely','Never','Not Applicable(e.g, only printing single sided documents)'];
  List<String> _question4 = ['Yes', 'No', 'Sometimes'];
  List<String> _question5 = ['1-10 pages', '11-50 pages', '51-100 pages','101-500 pages','more than 500 pages'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffEFF0EF),
      body:Padding(
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => FootPrintH2()));
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 55, right: 55, top: 20, bottom: 20),
              child: TopNavBarH(
                color1: Color(0xffA1C34A),
                bar1: Color(0xffA1C34A),
                color2: Color(0xffA1C34A),
                bar2: Color(0xffA1C34A),
                color3: Color(0xffA1C34A),
                bar3: Color(0xffA1C34A),
                color4: Color(0xffA1C34A),
                bar4: Color(0xffA1C34A),
                check: Color(0xffD9D9D9),
              ),
            ),
            Container(
              width: 450,
              height: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black12,
                  )
                ],
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Consumption',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xff2A3C24)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'In the consumption section, we assess the carbon footprint of students purchasing habits, focusing on their environmental consequences. Our aim is'
                            ' to identify areas for sustainable consumption practices to mitigate emissions.',
                        style:
                        TextStyle(fontSize: 15, color: Color(0xff757272)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildDropdownWithLabel('How often do you use the print shop for printing documents?', _selectedValue1, _question1, (newValue) {
                            setState(() {
                              _selectedValue1 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('What types of document do you typically print at the print shop?', _selectedValue2, _question2, (newValue) {
                            setState(() {
                              _selectedValue2 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('When using common print shop, how often do you opt for double-sided printing to save paper?', _selectedValue3, _question3, (newValue) {
                            setState(() {
                              _selectedValue3 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('When feasible, do you choose to keep documents in digital format instead of printing them out?', _selectedValue4, _question4, (newValue) {
                            setState(() {
                              _selectedValue4 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('On average, how many pages do you print shop?', _selectedValue5, _question5, (newValue) {
                            setState(() {
                              _selectedValue5 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          //Submit Button
                          Center(
                            child: RoundButton(
                              title: 'Next',
                              loading: loading,
                              onTap: () {
                                setState(() {
                                  loading = true;
                                });
                                _saveData();
                                setState(() {
                                  loading = false;
                                });
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => FootPrintH4()));
                                // Perform sign-in action
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildDropdownWithLabel(String label, String selectedValue, List<String> options, ValueChanged<String?> onChanged) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(color: Color(0xffA1C34A), fontSize: 18),
          ),
        ),
        SizedBox(width: 16),
        Container(
          width: 450, // Set a fixed width for the dropdown
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Color(0xffEFF0EF),
            border: Border.all(color: Color(0xffECEAEA)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedValue,
              onChanged: onChanged,
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                    style: TextStyle(color: Colors.black54),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
  void _saveData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final footPrintName = 'Consumption Section';

    Map<String, dynamic> data = {
      'footprintid': footPrintName,
      'Q1': _selectedValue1,
      'Q2': _selectedValue2,
      'Q3': _selectedValue3,
      'Q4': _selectedValue4,
      'Q5': _selectedValue5,

    };

    try {
      String currentuserid = FirebaseAuth.instance.currentUser!.uid;
      FootPrintSectionModel footPrintSectionModel = FootPrintSectionModel.empty();
      footPrintSectionModel.id = '3';
      footPrintSectionModel.name = footPrintName;
      List <QuestionModel> questions = [];
      questions.add(QuestionModel('0', 'How often do you use the print shop for printing documents?', '0'));
      questions.add(QuestionModel('1', 'What types of document do you typically print at the print shop?', '0'));
      questions.add(QuestionModel('2', 'When using common print shop, how often do you opt for double-sided printing to save paper?', '0'));
      questions.add(QuestionModel('3', 'When feasible, do you choose to keep documents in digital format instead of printing them out?', '0'));
      questions.add(QuestionModel('4', 'On average, how many pages do you print shop?', '0'));

      footPrintSectionModel.questions = questions;
      await footPrintSectionModel.saveToFirestore (uid: currentuserid, footprintCollectionName: 'Hosteller');

      // await firestore.collection('users').doc(currentuserid).collection('Hosteller').doc(footprintid).set(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save data: $e')));
    }
  }
}
