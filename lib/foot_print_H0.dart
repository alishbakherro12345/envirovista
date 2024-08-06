
import 'package:envirovista/foot_print_H1.dart';
import 'package:envirovista/foot_print_page.dart';
import 'package:envirovista/models/footprintsectionmodel.dart';
import 'package:envirovista/top_av_bar_H.dart';
import 'package:flutter/material.dart';
import 'package:envirovista/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FootPrintH0 extends StatefulWidget {
  const FootPrintH0({super.key});

  @override
  State<FootPrintH0> createState() => _FootPrintH0State();
}

class _FootPrintH0State extends State<FootPrintH0> {

  bool loading = false;
  String _selectedValue2 = 'Daily';
  String _selectedValue3 = 'Less than 5 times';
  String _selectedValue4 = 'Daily';
  String _selectedValue5 = 'Less than 30 minutes';

  final TextEditingController _question1 = TextEditingController();
  List<String> _question2 = ['Daily', 'Several times a day', 'Once a week','Less than Once a week'];
  List<String> _question3 = ['Less than 5 times', '5-10 times', '11-20 times','more than 20 times'];
  List<String> _question4 = ['Daily', 'Once a week','Several times a week', 'Less than Once a week'];
  List<String> _question5 = ['Less than 30 minutes', '30-90 minutes', '60-90 minutes','more than 90 minutes'];

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
            Padding(
              padding: const EdgeInsets.only(
                  left: 55, right: 55, top: 20, bottom: 20),
              child: TopNavBarH(
                color1: Color(0xffA1C34A),
                bar1: Color(0xffA1C34A),
                color2: Color(0xffD9D9D9),
                bar2: Color(0xffD9D9D9),
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
                        'Clothing',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xff2A3C24)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'In the clothing section, we evaluate the carbon'
                         ' footprint of students fashion choices, highlighting'
                      ' their environmental impact. Our objective is to'
                      ' propose sustainable clothing practices for minimizing emissions.',
                        style:
                        TextStyle(fontSize: 15, color: Color(0xff757272)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildTextFieldWithLabel('Your hostel name?', _question1),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('How often do you submit clothes for washing at the hostel laundry service? ', _selectedValue2, _question2, (newValue) {
                            setState(() {
                              _selectedValue2 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('On average, how many items of clothing do you submit to the hostel laundry services each time?  ', _selectedValue3, _question3, (newValue) {
                            setState(() {
                              _selectedValue3 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('How often do you use an iron?', _selectedValue4, _question4, (newValue) {
                            setState(() {
                              _selectedValue4 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('On average how long do you use the iron?', _selectedValue5, _question5, (newValue) {
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
                                        builder: (BuildContext context) => FootPrintH1()));
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
    final footPrintName = 'Clothing Section';

    Map<String, dynamic> data = {
      'footPrintName': footPrintName,
      'Q1': _question1.text,
      'Q2': _selectedValue2,
      'Q3': _selectedValue3,
      'Q4': _selectedValue4,
      'Q5': _selectedValue5,

    };

    try {
      String currentuserid = FirebaseAuth.instance.currentUser!.uid;
      FootPrintSectionModel footPrintSectionModel = FootPrintSectionModel.empty();
      footPrintSectionModel.id = '0';
      footPrintSectionModel.name = footPrintName;
      List <QuestionModel> questions = [];
      questions.add(QuestionModel('0', 'Your hostel name?', '0'));
      questions.add(QuestionModel('1', 'How often do you submit clothes for washing at the hostel laundry service? ', '0'));
      questions.add(QuestionModel('3', 'On average, how many items of clothing do you submit to the hostel laundry services each time?', '0'));
      questions.add(QuestionModel('4', 'How often do you use an iron?', '0'));
      questions.add(QuestionModel('5', 'On average how long do you use the iron?', '0'));
      footPrintSectionModel.questions = questions;
      await footPrintSectionModel.saveToFirestore (uid: currentuserid, footprintCollectionName: 'Hosteller');

     // await firestore.collection('users').doc(currentuserid).collection('Hosteller').doc(footPrintName).set(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save data: $e')));
    }
  }
}
