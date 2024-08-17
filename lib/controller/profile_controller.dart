import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {
  var pieChartNames = <String>[].obs;
  var pieChartPercentages = <double>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchResultData();
  }

  Future<void> fetchResultData() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      var snapshot = await firestore.collection('users').doc(userId).collection('Daily Schoolar').get();
      var docs = snapshot.docs;

      if (docs.isNotEmpty) {
        pieChartNames.clear();
        pieChartPercentages.clear();

        for (var doc in docs) {
          pieChartNames.add(doc['name']);
          pieChartPercentages.add(doc['sectionValue']);
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
