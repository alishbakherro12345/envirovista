import 'package:envirovista/models/footprintsectionmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FootprintResultCard extends StatefulWidget {
  final String title;
  final String value;
  final List<QuestionModel> questions;

  const FootprintResultCard({super.key, required this.title, required this.value, required this.questions});

  @override
  State<FootprintResultCard> createState() => _FootprintResultCardState();
}

class _FootprintResultCardState extends State<FootprintResultCard> with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffEFF0EF),
        border: Border.all(
          color: Color(0xff2A3C24), // Border color
          width: 1, // Border width
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.grey.withOpacity(0.3),
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 10),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            widget.value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              '(kg/year)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          AnimatedSize(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Column(
              children: isExpanded
                  ? [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Column(
                    children: [
                      for(int i=0; i<widget.questions.length; i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.questions[i].question,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Text(
                              widget.questions[i].modelValue,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      // Add more rows or content here if needed
                    ],
                  ),
                ),
              ]
                  : [],
            ),
          ),
          GestureDetector(
            onTap: toggleExpanded,
            child: Container(
              height: 50,
              width: double.infinity,
              child: Center(
                child: Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

