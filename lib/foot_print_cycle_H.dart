import 'package:envirovista/foot_print_1.dart';
import 'package:envirovista/foot_print_3.dart';
import 'package:envirovista/foot_print_4.dart';
import 'package:envirovista/foot_print_H3.dart';
import 'package:envirovista/foot_print_car.dart';
import 'package:envirovista/foot_print_car_H.dart';
import 'package:envirovista/foot_print_motorcycle.dart';
import 'package:envirovista/foot_print_motorcycle_H.dart';
import 'package:envirovista/foot_print_university_point.dart';
import 'package:envirovista/foot_print_university_point_H.dart';
import 'package:envirovista/top_av_bar_H.dart';
import 'package:flutter/material.dart';
import 'package:envirovista/roundbutton.dart';
import 'package:envirovista/top_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'custom_bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FootPrintCycleH extends StatefulWidget {
  const FootPrintCycleH({super.key});

  @override
  State<FootPrintCycleH> createState() => _FootPrintCycleHState();
}

class _FootPrintCycleHState extends State<FootPrintCycleH> {

  bool loading = false;

  String _selectedValue1 = 'Walking';
  String _selectedValue2 = 'Less than 1 km';
  final TextEditingController _question3 = TextEditingController();
  final TextEditingController _question4 = TextEditingController();
  String _selectedValue5 = 'Less than 10 minutes';



  List<String> _question1 = ['Walking', 'Cycle', 'Motorcycle', 'Car', 'University Point'];
  List<String> _question2 = ['Less than 1 km', '1 to 2 km', '2 to 3 km', 'More than 3 km'];
  List<String> _question5 = ['Less than 10 minutes', '10 to 20 minutes', '20 to 30 minutes', 'More than 3 minutes'];


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
                          _buildDropdownWithLabel('Approximately how far you walk/cycle to Department?', _selectedValue2, _question2, (newValue) {
                            setState(() {
                              _selectedValue2 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          _buildTextFieldWithLabel('Starting point', _question3),
                          SizedBox(height: 16),
                          _buildTextFieldWithLabel('Department (Destination point)', _question4),
                          SizedBox(height: 16),
                          _buildDropdownWithLabel('Approximately how long your walk/cycle is to the department?', _selectedValue5, _question5, (newValue) {
                            setState(() {
                              _selectedValue5 = newValue!;
                            });
                          }),
                          SizedBox(height: 16),
                          //Submit Button
                          Center(
                            child: RoundButton(
                              title: 'Submit',
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
                                        builder: (BuildContext context) => FootPrintCycleH()));
                                // Perform sign-in action
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
    final footprintid = 'Transport Section';

    Map<String, dynamic> data = {
      'footprintid': footprintid,
      'Q1': _selectedValue1,
      'Q2': _selectedValue1,
      'Q3': _question3.text,
      'Q4': _question4.text,
      'Q5': _selectedValue1,

    };

    try {
      String currentuserid = FirebaseAuth.instance.currentUser!.uid;
      await firestore.collection('users').doc(currentuserid).collection('Hosteller').doc(footprintid).set(data);
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