import 'package:envirovista/foot_print_2.dart';
import 'package:envirovista/foot_print_H0.dart';
import 'package:envirovista/foot_print_H2.dart';
import 'package:envirovista/foot_print_page.dart';
import 'package:envirovista/roundbutton.dart';
import 'package:envirovista/top_av_bar_H.dart';
import 'package:envirovista/top_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'models/footprintsectionmodel.dart';

class FootPrintH1 extends StatefulWidget {
  const FootPrintH1({super.key});

  @override
  State<FootPrintH1> createState() => _FootPrintH1State();
}

class _FootPrintH1State extends State<FootPrintH1> {
  bool loading = false;

  String _selectedValue1 = 'Multiple times a day';
  String _selectedValue2 = 'Beef';
  String _selectedValue3 = 'Small portions(Less than 100 grams)';
  String _selectedValue4 = 'Multiple times a day';
  String _selectedValue5 = '0.25 kg';
  String _selectedValue6 = 'Multiple times a day';
  String _selectedValue7 = '0.25 kg';
  String _selectedValue8 = 'Multiple times a day';
  String _selectedValue9 = 'Less than 100 ml';
  String _selectedValue10 = 'Multiple times a day';
  List<String> _selectedValues11 = [];



  List<String> _question1 = ['Multiple times a day', 'Once a day', 'Several times a day', 'Once a week', 'Less often', 'I am vegetarian/vegan'];
  List<String> _question2 = ['Beef', 'Chicken', 'Meat','None'];
  List<String> _question3 = ['Small portions(Less than 100 grams)', 'Medium portions(100-200 grams)', 'Large portions(more than 200 grams)'];
  List<String> _question4 = ['Multiple times a day', 'Once a day', 'Several times a day', 'Once a week', 'Rarely or Often'];
  List<String> _question5 = ['0.25 kg', '0.5 kg', '0.75 kg','1 kg','2 kg or more'];
  List<String> _question6 = ['Multiple times a day', 'Once a day', 'Several times a day', 'Once a week', 'Rarely or Often'];
  List<String> _question7 = ['0.25 kg', '0.5 kg', '0.75 kg','1 kg'];
  List<String> _question8 = ['Multiple times a day', 'Once a day', 'Several times a day', 'Once a week', 'Rarely or Often'];
  List<String> _question9 = ['Less than 100 ml', '100 ml to 200 ml', '250 ml to 500 ml', 'More than 500 ml'];
  List<String> _question10 = ['Multiple times a day', 'Once a day', 'Several times a day', 'Once a week', 'Rarely or Often'];
  List<String> _question11 = ['IT Canteen', 'Falafel MUET', 'MUISTD Canteen', 'Civil Canteen', 'Textile Canteen','Water Tesource Canteen','Hill Top Canteen','Electronics Canteen','Student Teacher Canteen','Central Cafeteria MUET'];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                        builder: (BuildContext context) => FootPrintH0()));
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
                color3: Color(0xffD9D9D9),
                bar3: Color(0xffD9D9D9),
                color4: Color(0xffD9D9D9),
                bar4: Color(0xffD9D9D9),
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
                        'Food',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xff2A3C24)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'In this section, we evaluate the carbon footprint of individual '
                            'students food choices at the university, shedding light on their environmental '
                            'impact. By analyzing dietary habits, we aim to '
                            'identify opportunities for reducing emissions.',
                        style:
                        TextStyle(fontSize: 15, color: Color(0xff757272)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildDropdownWithLabel('How often do you eat /chicken while at university?', _selectedValue1, _question1, (newValue) {
                            setState(() {
                              _selectedValue1 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('Which type of meat do you mostly consume?', _selectedValue2, _question2, (newValue) {
                            setState(() {
                              _selectedValue2 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('Typically how much meal do you consume in one meal at university?', _selectedValue3, _question3, (newValue) {
                            setState(() {
                              _selectedValue3 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('How frequently do you eat rice while at university?', _selectedValue4, _question4, (newValue) {
                            setState(() {
                              _selectedValue4 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('What are the typical portion sizes of rice in your meals at university?', _selectedValue5, _question5, (newValue) {
                            setState(() {
                              _selectedValue5 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('How often do you include vegetables in your meals at university?', _selectedValue6, _question6, (newValue) {
                            setState(() {
                              _selectedValue6 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('What are the typical portion sizes of vegetables in your meals at university?', _selectedValue7, _question7, (newValue) {
                            setState(() {
                              _selectedValue7 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('How often do you consume milk at university?(can be in terms of milkshake/Tea)', _selectedValue8, _question8, (newValue) {
                            setState(() {
                              _selectedValue8 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('On average, how much milk do you consume pr day at university?', _selectedValue9, _question9, (newValue) {
                            setState(() {
                              _selectedValue9 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('How often do you consume fruit at university?(can be in terms of milkshake)', _selectedValue10, _question10, (newValue) {
                            setState(() {
                              _selectedValue10 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildMultiSelectDropdown('Where do you primarily get your milk and fruit from at university?(tea and milkshake)', _selectedValues11, _question11),
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
                                        builder: (BuildContext context) => FootPrintH2()));
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
  Widget _buildMultiSelectDropdown(String label, List<String> selectedValues, List<String> options) {
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
              hint: Text(selectedValues.isEmpty ? 'Select Options' : selectedValues.join(', ')),
              onChanged: (_) {}, // No need to change anything here
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      final bool isSelected = selectedValues.contains(value);
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedValues.remove(value);
                            } else {
                              selectedValues.add(value);
                            }
                          });
                          // Close the dropdown menu after selection
                          Navigator.pop(context);
                          // Refresh the parent widget
                          this.setState(() {});
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              value: isSelected,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  if (newValue!) {
                                    selectedValues.add(value);
                                  } else {
                                    selectedValues.remove(value);
                                  }
                                });
                                // Close the dropdown menu after selection
                                Navigator.pop(context);
                                // Refresh the parent widget
                                this.setState(() {});
                              },
                            ),
                            Text(value,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      );
                    },
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
    final footPrintName = 'food section';

    Map<String, dynamic> data = {
      'footprintid': footPrintName,
      'Q1': _selectedValue1,
      'Q2': _selectedValue2,
      'Q3': _selectedValue3,
      'Q4': _selectedValue4,
      'Q5': _selectedValue5,
      'Q6': _selectedValue6,
      'Q7': _selectedValue7,
      'Q8': _selectedValue8,
      'Q9': _selectedValue9,
      'Q10': _selectedValue10,
      'Q11': _selectedValues11,
    };

    try {
      String currentuserid = FirebaseAuth.instance.currentUser!.uid;
      FootPrintSectionModel footPrintSectionModel = FootPrintSectionModel.empty();
      footPrintSectionModel.id = '1';
      footPrintSectionModel.name = footPrintName;
      List <QuestionModel> questions = [];
      questions.add(QuestionModel('0', 'How often do you eat /chicken while at university?', '0'));
      questions.add(QuestionModel('1', 'Which type of meat do you mostly consume?', '0'));
      questions.add(QuestionModel('2', 'On average, how many items of clothing do you submit to the hostel laundry services each time?', '0'));
      questions.add(QuestionModel('3', 'How frequently do you eat rice while at university?', '0'));
      questions.add(QuestionModel('4', 'What are the typical portion sizes of rice in your meals at university?', '0'));
      questions.add(QuestionModel('5', 'How often do you include vegetables in your meals at university?', '0'));
      questions.add(QuestionModel('6', 'What are the typical portion sizes of vegetables in your meals at university?', '0'));
      questions.add(QuestionModel('7', 'How often do you consume milk at university?(can be in terms of milkshake/Tea)', '0'));
      questions.add(QuestionModel('8', 'On average, how much milk do you consume pr day at university?', '0'));
      questions.add(QuestionModel('9', 'How often do you consume fruit at university?(can be in terms of milkshake)', '0'));
      questions.add(QuestionModel('10', 'Where do you primarily get your milk and fruit from at university?(tea and milkshake)', '0'));



      footPrintSectionModel.questions = questions;
      await footPrintSectionModel.saveToFirestore (uid: currentuserid, footprintCollectionName: 'Hosteller');

      //await firestore.collection('users').doc(currentuserid).collection('Hosteller').doc(footprintid).set(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save data: $e')));
    }
  }
}
