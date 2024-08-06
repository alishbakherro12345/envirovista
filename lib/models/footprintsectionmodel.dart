import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FootPrintSectionModel {
  String id = '';
  String name = '';
  String description = '';
  List<QuestionModel> questions = [];
  double sectionValue = 0.0;

  FootPrintSectionModel.empty();

  FootPrintSectionModel(
      this.id, this.name, this.description, this.questions, this.sectionValue);

  FootPrintSectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    sectionValue = json['sectionValue'];
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions.add(QuestionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'questions': questions.map((e) => e.toJson()).toList(),
    'sectionValue': sectionValue
  };

  // Method to save the model to Firestore this method call when you add a footprint section to the Firestore
  Future<bool> saveToFirestore(
      {required String uid, required String footprintCollectionName}) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection(footprintCollectionName)
          .doc(id)
          .set(toJson());
      return true;
    } catch (e) {
      print('Error saving document: $e');
      return false;
    }
  }

  // Method to update the model to Firestore this method call when you update a footprint section to the Firestore
  Future<bool> updateToFirestore(
      {required String uid, required String footprintCollectionName}) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection(footprintCollectionName)
          .doc(id)
          .update(toJson());
      return true;
    } catch (e) {
      print('Error updating document: $e');
      return false;
    }
  }

  // Method to delete the model to Firestore this method call when you delete a footprint section to the Firestore
  Future<bool> deleteFromFirestore(
      {required String uid, required String footprintCollectionName}) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection(footprintCollectionName)
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      print('Error deleting document: $e');
      return false;
    }
  }

  // Method to get the model from Firestore this method call when you get a footprint section from the Firestore
  static Future<FootPrintSectionModel?> getFromFirestore(
      {required String uid,
        required String footprintCollectionName,
        required String id}) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final doc = await firestore
          .collection('users')
          .doc(uid)
          .collection(footprintCollectionName)
          .doc(id)
          .get();
      if (doc.exists) {
        return FootPrintSectionModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting document: $e');
      return null;
    }
  }

  // Method to get all the models from Firestore this method call when you get all the footprint sections from the Firestore
  static Stream<List<FootPrintSectionModel>> getAllFromFirestore({
    required String uid,
    required String footprintCollectionName,
  }) {
    final firestore = FirebaseFirestore.instance;
    return firestore
        .collection('users')
        .doc(uid)
        .collection(footprintCollectionName)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => FootPrintSectionModel.fromJson(doc.data()))
          .toList();
      });
  }
}


class QuestionModel {
  String id = '';
  String question = '';
  String modelValue = '';
  String selectedValue = '';


  QuestionModel.empty();

  QuestionModel(this.id, this.question, this.modelValue, [this.selectedValue = '']);

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    modelValue = json['modelValue'];
    selectedValue = json['selectedValue'];

  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'question': question, 'modelValue': modelValue, 'selectedValue':selectedValue.toString() };
}
