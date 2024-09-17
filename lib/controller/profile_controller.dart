import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {
  var pieChartNames = <String>[].obs;
  var pieChartPercentages = <double>[].obs;
  var totalPercentages = <double>[].obs;

  @override
  void onInit() {
    super.onInit();
    _startListeningToData();
  }

  double get totalPercentage => pieChartPercentages.fold(0, (sum, item) => sum + item);

  void _startListeningToData() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('users').doc(userId).collection('Daily Schoolar').snapshots().listen((snapshot) {
      var docs = snapshot.docs;

      if (docs.isNotEmpty) {
        pieChartNames.clear();
        pieChartPercentages.clear();

        for (var doc in docs) {
          pieChartNames.add(doc['name']);
          pieChartPercentages.add(doc['sectionValue']);
        }
      }
    });
  }
}

