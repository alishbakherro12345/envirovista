import 'package:envirovista/utils/dailyschoolarfootprint/foot_print_1.dart';
import 'package:envirovista/utils/dailyschoolarfootprint/foot_print_3.dart';
import 'package:flutter/material.dart';
import 'package:envirovista/roundbutton.dart';
import 'package:envirovista/utils/dailyschoolarfootprint/top_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../custom_bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/footprintsectionmodel.dart';

class FootPrint2 extends StatefulWidget {
  const FootPrint2({super.key});

  @override
  State<FootPrint2> createState() => _FootPrint2State();
}

class _FootPrint2State extends State<FootPrint2> {
  bool loading = false;

  String _selectedValue1 = 'Department';
  String _selectedValue2 = 'I use it continuesly throughout the day';
  String _selectedValue3 = 'Below 20C degree (68F degree)';
  String _selectedValue4 = 'I do not have an air conditioner';
  String _selectedValue5 = 'Desktop';
  String _selectedValue8 = 'Yes';
  String _selectedValue9 = 'Less than two hours';
  String _selectedValue10 = 'New one';



  List<String> _question1 = ['Department', 'Hostel', 'I dot have an air conditioner'];
  List<String> _question2 = ['I use it continuesly throughout the day', 'I use it only during the hottest part of the day','I use it only at night','I rarely use it ','I do not have an air conditioner'];
  List<String> _question3 = ['Below 20C degree (68F degree)', '20C degree to 22C degree (68F degree to 72F degree )', '23C degree to 25C degree (73F degree to 75F degree )','Above 25C degree (77F degree )','I do not have an air conditioner'];
  List<String> _question4 = ['I do not have an air conditioner', 'Less than 4 hours', '4 to 8 hours', '8 to 12 hours', 'More than 12 hours'];
  List<String> _question5 = ['Desktop', 'Computer'];
  final TextEditingController _question6 = TextEditingController();
  final TextEditingController _question7 = TextEditingController();
  List<String> _question8 = ['Yes', 'No'];
  List<String> _question9 = ['Less than two hours','2 to 4 hours','4 to 8 hours','More than 8 hours'];
  List<String> _question10 = ['New one', 'Second Hand'];
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
                        builder: (BuildContext context) => FootPrint1()));
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
              child: TopNavBar(
                color1: Color(0xffA1C34A),
                bar1: Color(0xffA1C34A),
                color2: Color(0xffA1C34A),
                bar2: Color(0xffA1C34A),
                color3: Color(0xffD9D9D9),
                bar3: Color(0xffD9D9D9),
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
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Housing',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xff2A3C24)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'In housing, we gauge the carbon footprint of students accommodations, emphasizing their '
                      'environmental impact. This assessment aims to suggest sustainable strategies for emission reduction.',
                        style:
                        TextStyle(fontSize: 15, color: Color(0xff757272)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildDropdownWithLabel('Where do you have an air conditioner?', _selectedValue1, _question1, (newValue) {
                            setState(() {
                              _selectedValue1 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('How often do you use air conditioner in your hostel or department during hot whether?', _selectedValue2, _question2, (newValue) {
                            setState(() {
                              _selectedValue2 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('What temperature do you usually set your air conditioner to during use?', _selectedValue3, _question3, (newValue) {
                            setState(() {
                              _selectedValue3 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('On average, how long is the air conditioner active in your living space each day during warm cloths?', _selectedValue4, _question4, (newValue) {
                            setState(() {
                              _selectedValue4 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('What type of device do you primarily use for your academic work?', _selectedValue5, _question5, (newValue) {
                            setState(() {
                              _selectedValue5 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildTextFieldWithLabel('Off which brand your computer/laptop is?', _question6),
                          SizedBox(height: 16),
                          _buildTextFieldWithLabel('What is the generation of your laptop?', _question7),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('Does it have a graphic cards?', _selectedValue8, _question8, (newValue) {
                            setState(() {
                              _selectedValue8 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('How many hours per day do you typically use your laptop or computer?', _selectedValue9, _question9, (newValue) {
                            setState(() {
                              _selectedValue9 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('Do you have a second hand laptop or computer or new?', _selectedValue10, _question10, (newValue) {
                            setState(() {
                              _selectedValue10 = newValue!;
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
                                        builder: (BuildContext context) => FootPrint3()));
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
  void _saveData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final footPrintName = 'Housing';

    Map<String, dynamic> data = {
      'footprintid': footPrintName,
      'Q1': _selectedValue1,
      'Q2': _selectedValue2,
      'Q3': _selectedValue3,
      'Q4': _selectedValue4,
      'Q5': _selectedValue5,
      'Q6': _question6.text,
      'Q7': _question7.text,
      'Q8': _selectedValue8,
      'Q9': _selectedValue9,
      'Q10': _selectedValue10,
    };

    try {
      String currentuserid = FirebaseAuth.instance.currentUser!.uid;
      FootPrintSectionModel footPrintSectionModel = FootPrintSectionModel.empty();
      footPrintSectionModel.id = '2';
      footPrintSectionModel.name = footPrintName;
      footPrintSectionModel.sectionValue=20;
      List <QuestionModel> questions = [];
      questions.add(QuestionModel('0', 'Where do you have an air conditioner?', '0',_selectedValue1));
      questions.add(QuestionModel('1', 'How often do you use air conditioner in your hostel or department during hot whether?', '0',_selectedValue2));
      questions.add(QuestionModel('2', 'What temperature do you usually set your air conditioner to during use?', '0',_selectedValue3));
      questions.add(QuestionModel('3', 'On average, how long is the air conditioner active in your living space each day during warm cloths?', '0',_selectedValue4));
      questions.add(QuestionModel('4', 'What type of device do you primarily use for your academic work?', '0',_selectedValue5));
      questions.add(QuestionModel('5', 'Off which brand your computer/laptop is?', '0',_question6.text));
      questions.add(QuestionModel('6', 'What is the generation of your laptop?', '0',_question7.text));
      questions.add(QuestionModel('7', 'Does it have a graphic cards?', '0',_selectedValue8));
      questions.add(QuestionModel('8', 'How many hours per day do you typically use your laptop or computer?', '0',_selectedValue9));
      questions.add(QuestionModel('9', 'Do you have a second hand laptop or computer or new?', '0',_selectedValue10));

      footPrintSectionModel.questions = questions;
      await footPrintSectionModel.saveToFirestore (uid: currentuserid, footprintCollectionName: 'Footprint');
      //await firestore.collection('users').doc(currentuserid).collection('Daily Schooler').doc(footprintid).set(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save data: $e')));
    }
  }
}
