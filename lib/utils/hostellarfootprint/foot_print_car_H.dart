import 'package:envirovista/utils/dailyschoolarfootprint/foot_print_1.dart';
import 'package:envirovista/utils/dailyschoolarfootprint/foot_print_3.dart';
import 'package:envirovista/utils/dailyschoolarfootprint/foot_print_4.dart';
import 'package:envirovista/utils/footprint/footprint_result.dart';
import 'package:envirovista/utils/hostellarfootprint/foot_print_H3.dart';
import 'package:envirovista/utils/dailyschoolarfootprint/foot_print_cycle.dart';
import 'package:envirovista/utils/hostellarfootprint/foot_print_cycle_H.dart';
import 'package:envirovista/utils/dailyschoolarfootprint/foot_print_motorcycle.dart';
import 'package:envirovista/utils/hostellarfootprint/foot_print_motorcycle_H.dart';
import 'package:envirovista/utils/dailyschoolarfootprint/foot_print_university_point.dart';
import 'package:envirovista/utils/hostellarfootprint/foot_print_university_point_H.dart';
import 'package:envirovista/utils/hostellarfootprint/top_av_bar_H.dart';
import 'package:flutter/material.dart';
import 'package:envirovista/roundbutton.dart';
import 'package:envirovista/utils/dailyschoolarfootprint/top_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../custom_bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/footprintsectionmodel.dart';

class FootPrintCarH extends StatefulWidget {
  const FootPrintCarH({super.key});

  @override
  State<FootPrintCarH> createState() => _FootPrintCarHState();
}

class _FootPrintCarHState extends State<FootPrintCarH> {

  bool loading = false;

  String _selectedValue1 = 'Car';
  String _selectedValue4 = 'Daily';
  String _selectedValue5 = 'Gasoline';
  String _selectedValue9 = 'Less than 10 minutes';


  List<String> _question1 = ['Walking', 'Cycle', 'Motorcycle', 'Car', 'University Point'];
  final TextEditingController _question2 = TextEditingController();
  final TextEditingController _question3 = TextEditingController();
  List<String> _question4 = ['Daily', 'Several times a day', 'Once a week', 'Ocasionally'];
  List<String> _question5 = ['Gasoline', 'Diesel', 'Hybrid', 'Electric'];
  final TextEditingController _question6 = TextEditingController();
  final TextEditingController _question7 = TextEditingController();
  final TextEditingController _question8 = TextEditingController();
  List<String> _question9 = ['Less than 10 minutes', '10 to 20 minutes', '20 to 30 minutes', 'more than 30 minutes'];
  final TextEditingController _question10 = TextEditingController();



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
                    weight: 20,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => FootPrintH3()));
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
                  top: 20, bottom: 20),
              child: TopNavBarH(
                color1: Color(0xffA1C34A),
                bar1: Color(0xffA1C34A),
                color2: Color(0xffA1C34A),
                bar2: Color(0xffA1C34A),
                color3: Color(0xffA1C34A),
                bar3: Color(0xffA1C34A),
                color4: Color(0xffA1C34A),
                bar4: Color(0xffA1C34A),
                check: Color(0xffA1C34A),
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
                        'Transportation',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xff2A3C24)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'In transportation, we examine the carbon footprint of students travel habits, emphasizing '
                            'environmental implications. Our goal is to suggest sustainable transportation alternatives to reduce emissions.',
                        style:
                        TextStyle(fontSize: 15, color: Color(0xff757272)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildDropdownWithLabel(
                              'What is your primary mode of transportation for commuting to and from university?',
                              _selectedValue1,
                              _question1, (newValue) {
                            setState(() {
                              _selectedValue1 = newValue!;
                              _saveData().then((success) {
                                if (success) {
                                  _navigateBasedOnSelection();
                                }
                              });
                            });
                          }),
                          SizedBox(height: 16),
                          _buildTextFieldWithLabel('Starting Point', _question2),
                          SizedBox(height: 16),
                          _buildTextFieldWithLabel('Destination (Department)', _question3),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('How often do you use your car for commuting university?', _selectedValue4, _question4, (newValue) {
                            setState(() {
                              _selectedValue4 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('What type of car do you primarily use for ?', _selectedValue5, _question5, (newValue) {
                            setState(() {
                              _selectedValue5 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildTextFieldWithLabel('Approximately how many kilometers do you travel one way from home to university?', _question6),
                          SizedBox(height: 16),
                          _buildTextFieldWithLabel('Approximately how many time do you travel one way from home to university?', _question7),
                          SizedBox(height: 16),
                          _buildTextFieldWithLabel('Manufacturer of your car?', _question8),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('What is the engine capacity(cc) of your car?', _selectedValue9, _question9, (newValue) {
                            setState(() {
                              _selectedValue9 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildTextFieldWithLabel('How much fuel is consumed in a round trip?(from: home to uni and vice versa)', _question8),
                          SizedBox(height: 16),
                          //Submit Button
                          Center(
                            child: RoundButton(
                              title: 'Submit',
                              loading: loading,
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                });

                                bool success = await _saveData(); // Await data saving result

                                if (success) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => FootprintResult(),
                                    ),
                                  );
                                }

                                setState(() {
                                  loading = false;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    if (loading)
                      CircularProgressIndicator(color: Colors.lightGreen),
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
  Widget _buildTextFieldWithLabel(String label, TextEditingController controller) {
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
          width: 450,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Color(0xffEFF0EF),
            border: Border.all(color: Color(0xffECEAEA)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here...',
            ),
          ),
        ),
      ],
    );
  }
  Future<bool> _saveData() async {
    setState(() {
      loading = true;
    });

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final footPrintName = 'Transport';

    Map<String, dynamic> data = {
      'footprintid': footPrintName,

      'Q1': _selectedValue1,
      'Q2': _question2.text,
      'Q3': _question3.text,
      'Q4': _selectedValue4,
      'Q5': _selectedValue5,
      'Q6': _question6.text,
      'Q7': _question7.text,
      'Q8': _question8.text,
      'Q9': _selectedValue9,
      'Q10': _question10.text,

    };

    try {
      String currentuserid = FirebaseAuth.instance.currentUser!.uid;
      FootPrintSectionModel footPrintSectionModel = FootPrintSectionModel.empty();
      footPrintSectionModel.id = '4';
      footPrintSectionModel.name = footPrintName;
      footPrintSectionModel.sectionValue=20;
      List <QuestionModel> questions = [];
      questions.add(QuestionModel('0', 'What is your primary mode of transportation for commuting to and from university?', '0'));
      questions.add(QuestionModel('1', 'Starting Point', '0'));
      questions.add(QuestionModel('2', 'Destination (Department)', '0'));
      questions.add(QuestionModel('3', 'How often do you use your car for commuting university?', '0'));
      questions.add(QuestionModel('4', 'What type of car do you primarily use for ?', '0'));
      questions.add(QuestionModel('5', 'Approximately how many kilometers do you travel one way from home to university?', '0'));
      questions.add(QuestionModel('6', 'Approximately how many time do you travel one way from home to university?', '0'));
      questions.add(QuestionModel('7', 'Manufacturer of your car?', '0'));
      questions.add(QuestionModel('8', 'What is the engine capacity(cc) of your car?', '0'));
      questions.add(QuestionModel('9', 'How much fuel is consumed in a round trip?(from: home to uni and vice versa)', '0'));

      footPrintSectionModel.questions = questions;
      await footPrintSectionModel.saveToFirestore (uid: currentuserid, footprintCollectionName: 'Hosteller');
      //await firestore.collection('users').doc(currentuserid).collection('Hosteller').doc(footprintid).set(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully!')));
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save data: $e')));
      return false;
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
  void _navigateBasedOnSelection() {
    switch (_selectedValue1) {
      case 'Walking':
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => FootPrintCycleH()));
        break;
      case 'Cycle':
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => FootPrintCycleH()));
        break;
      case 'Motorcycle':
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => FootPrintMotorcycleH()));
        break;
      case 'Car':
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => FootPrintCarH()));
        break;
      case 'University Point':
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => FootPrintUniversityPointH()));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Option selected: $_selectedValue1')));
    }
  }
}