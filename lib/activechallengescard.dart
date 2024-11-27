import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ActiveChallengesCard extends StatelessWidget {
  final String title;
  final String imagepath;
  final String userId;

  const ActiveChallengesCard({
    Key? key,
    required this.title,
    required this.imagepath,
    required this.userId,
  }) : super(key: key);

  Stream<double> _getCompletionPercentageStream() {
    return FirebaseFirestore.instance
        .collection('challenges')
        .doc(title)
        .collection('tasks')
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        return 0.0;
      }
      int completedTasks = querySnapshot.docs.where((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return (data['completionStatus']?[userId] ?? false) == true;
      }).length;
      double completionPercentage = (completedTasks / querySnapshot.docs.length) * 100;

      // Update completion percentage in Firestore
      FirebaseFirestore.instance.collection('challenges').doc(title).update({
        'completionPercentage.$userId': completionPercentage,
      });

      return completionPercentage;
    }).handleError((error) {
      print('Error calculating completion percentage: $error');
      return 0.0;
    }).cast<double>();
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _ChallengeDetailsDialog(
            title: title,
            userId: userId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          _showPopup(context); // Show popup on tap
        },
        child: Container(
          width: 185,
          height: 165,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Color(0xff66B630),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Column(
              children: [
                Image(image: AssetImage(imagepath)),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                StreamBuilder<double>(
                  stream: _getCompletionPercentageStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(color: Colors.green,);
                    }
                    if (snapshot.hasError) {
                      return Text('Error');
                    }
                    double completionPercentage = snapshot.data ?? 0.0;
                    return Text(
                      '${completionPercentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffA1C34A),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChallengeDetailsDialog extends StatefulWidget {
  final String title;
  final String userId;

  const _ChallengeDetailsDialog({
    Key? key,
    required this.title,
    required this.userId,
  }) : super(key: key);

  @override
  __ChallengeDetailsDialogState createState() => __ChallengeDetailsDialogState();
}

class __ChallengeDetailsDialogState extends State<_ChallengeDetailsDialog> {
  late List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  void _fetchTasks() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('challenges')
          .doc(widget.title)
          .collection('tasks')
          .get();

      setState(() {
        tasks = querySnapshot.docs.map((doc) {
          return Task(
            title: doc['title'],
            isCompleted: (doc.data() as Map<String, dynamic>)['completionStatus']?[widget.userId] ?? false,
            documentId: doc.id,
          );
        }).toList();
      });
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  void _updateTaskCompletion(Task task, bool newValue) async {
    try {
      await FirebaseFirestore.instance
          .collection('challenges')
          .doc(widget.title)
          .collection('tasks')
          .doc(task.documentId)
          .update({
        'completionStatus.${widget.userId}': newValue,
      });
      // Update the percentage of completion
      double newPercentage = await _calculateAndUpdateCompletionPercentage();
      await FirebaseFirestore.instance
          .collection('challenges')
          .doc(widget.title)
          .update({
        'completionPercentage.${widget.userId}': newPercentage,
      });
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<double> _calculateAndUpdateCompletionPercentage() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('challenges')
        .doc(widget.title)
        .collection('tasks')
        .get();

    int completedTasks = querySnapshot.docs.where((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return (data['completionStatus']?[widget.userId] ?? false) == true;
    }).length;

    if (querySnapshot.docs.isEmpty) {
      return 0.0;
    }
    return (completedTasks / querySnapshot.docs.length) * 100;
  }

  Stream<bool> _getTaskCompletionStream(Task task) {
    return FirebaseFirestore.instance
        .collection('challenges')
        .doc(widget.title)
        .collection('tasks')
        .doc(task.documentId)
        .snapshots()
        .map((docSnapshot) {
      return (docSnapshot.data() as Map<String, dynamic>)['completionStatus']?[widget.userId] ?? false;
    }).handleError((error) {
      print('Error fetching task completion status: $error');
      return false;
    }).cast<bool>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Challenge Details', // Replace with a long title if needed
            style: TextStyle(color: Color(0xff66B630)),
            softWrap: true,   // Ensures text wraps within available space
            maxLines: null,   // Allows unlimited lines for wrapping
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: tasks.map((task) {
          return StreamBuilder<bool>(
            stream: _getTaskCompletionStream(task),
            builder: (context, snapshot) {
              bool isCompleted = snapshot.data ?? task.isCompleted;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return Row(
                children: [
                  Checkbox(
                    value: isCompleted,
                    activeColor: isCompleted ? Color(0xff66B630) : Colors.grey,
                    onChanged: (value) {
                      _updateTaskCompletion(task, value ?? false);
                    },
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(overflow: TextOverflow.visible), // Makes sure the full text is visible
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: TextStyle(color: Color(0xff66B630)),
          ),
        ),
      ],
    );
  }

}

class Task {
  String title;
  bool isCompleted;
  String documentId;

  Task({
    required this.title,
    required this.isCompleted,
    required this.documentId,
  });
}
