import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/data/models/transactions.dart';
import 'package:sales_report_app/app/data/repositories/transactions_repositories.dart';

import '../../../data/repositories/user_repositories.dart';

class AdminTxController extends GetxController {
  final popupBuilderKey = GlobalKey<DropdownSearchState<String>>();
  final trxFormKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final weightController = TextEditingController();
  final dateController = TextEditingController();
  final userRepo = UserRepository.instance;
  final txRepo = TransactionRepository.instance;

  String? selectedName;

  String? validator(String? value) {
    return null;
  }

  void onClose() {
    priceController.dispose();
    weightController.dispose();
    super.onClose();
  }

  Stream<List<String>> streamName() {
    Query<Map<String, dynamic>> itemsRef = FirebaseFirestore.instance
        .collection('Users')
        .orderBy("name", descending: false);
    return itemsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  // Stream<List<String>> streamCar() {
  //   return FirebaseFirestore.instance
  //       .collection('Users')
  //       .where('name', isEqualTo: selectedName)
  //       .snapshots()
  //       .map((snapshot) {
  //     final userDoc = snapshot.docs.first;

  //     return userDoc.reference
  //         .collection("Cars")
  //         .snapshots()
  //         .map((carsSnapshot) {
  //       return carsSnapshot.docs
  //           .map((carDoc) => carDoc['carNumber'] as String)
  //           .toList();
  //     }).t
  //   });
  // }

  // Stream<List<String>> streamCar() {
  //   // String? userID = getUserIdFromName(selectedName.toString()).toString();

  //   Query<Map<String, dynamic>> carRef = FirebaseFirestore.instance
  //       .collection('Users')
  //       // .doc('${getUserIdFromName(selectedName.toString())}')
  //       .doc('${AuthController.instance.firebaseAuth.currentUser!.uid}')
  //       // .doc(userID)
  //       .collection("Cars");
  //   // .where('name', isEqualTo: selectedName);
  //   return carRef.snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) => doc['carNumber'] as String).toList();
  //   });
  // }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getCarNumbersStream(
  //     String selectedName) {
  //   return userRepo.userCollection
  //       .where('name', isEqualTo: selectedName)
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.first.reference.collection('Cars').snapshots());
  // }

  void addNewTx() async {
    if (trxFormKey.currentState!.validate()) {
      int harga = int.parse(priceController.text);
      int berat = int.parse(weightController.text);
      // DateTime tanggal = tanggalController.text as DateTime;

      String? userID = await getUserIdFromName(selectedName.toString());

      if (userID != null) {
        await txRepo.addTx(
          Transactions(
            userID: userID,
            transactionID: txRepo.txCollection.doc().id,
            name: selectedName.toString(),
            price: harga,
            weight: berat,
          ),
        );
        Get.defaultDialog(
          title: 'Success',
          middleText: "Data added.",
          onConfirm: () {
            priceController.clear();
            weightController.clear();
            Get.back(); //close dialog
          },
          textConfirm: 'Okay',
        );
      }
    }
  }

  Future<String?> getUserIdFromName(String selectedName) async {
    // Get a reference to the Firestore collection
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');

    // Query the collection to find the document with the matching name
    QuerySnapshot<Object?> snapshot = await usersCollection
        .where('name', isEqualTo: selectedName)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Retrieve the first document from the query snapshot
      QueryDocumentSnapshot<Object?> documentSnapshot = snapshot.docs[0];

      // Retrieve and return the document ID
      return documentSnapshot.id;
    }

    return null; // Return null if no matching document found
  }
}
