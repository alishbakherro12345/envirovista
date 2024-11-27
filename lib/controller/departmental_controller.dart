import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentalController extends GetxController {
  var pieChartNames = <String>[].obs;
  var pieChartPercentages = <double>[].obs;

  @override
  void onInit() {
    super.onInit();
    _startListeningToData();
  }
  double get totalPercentage => pieChartPercentages.fold(0, (sum, item) => sum + item);

  void _startListeningToData() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore
        .collection('department')
        .doc('CS')
        .snapshots()
        .listen((snapshot) {
      var data = snapshot.data();

      if (data != null) {
        pieChartNames.clear();
        pieChartPercentages.clear();

        // Iterate over all fields in the document and process them
        data.forEach((key, value) {
          // Assuming all values are numeric and can be converted to double
          if (value is num) {
            // Add the field name as the pie chart label
            pieChartNames.add(key);

            // Add the field value (converted to double) to the pie chart percentages
            pieChartPercentages.add(value.toDouble());
          }
        });

        // Optionally, add the remaining percentage if needed
        var totalPercentage = pieChartPercentages.reduce((a, b) => a + b);
        // if (totalPercentage < 100) {
        //   pieChartNames.add('Remaining');
        //   pieChartPercentages.add((100 - totalPercentage).toDouble());
        // }
      }
    });
  }
}

